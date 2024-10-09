import MySQLNIO
import Foundation
import NIO

class DatabaseService {
    private var connection: MySQLConnection!
    private let eventLoopGroup: EventLoopGroup

    init() {
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            let address = try SocketAddress.makeAddressResolvingHost("35.244.90.249", port: 3306)
            
            // 配置数据库连接
            self.connection = try MySQLConnection.connect(
                to: address,
                username: "deco7381northwind",
                database: "deco7381northwind",
                password: "123456",
                tlsConfiguration: nil,
                on: eventLoopGroup.next()
            ).wait()
        } catch {
            print("数据库连接失败: \(error)")
            fatalError("无法连接到数据库")
        }
    }

    // 获取单词的方法
    func fetchWords(completion: @escaping ([Word]) -> Void) {
        let query = "SELECT text, translation FROM review"
        connection.query(query).whenComplete { result in
            switch result {
            case .success(let rows):
                var words: [Word] = []
                for row in rows {
                    if let word = row.column("text")?.string, let translation = row.column("translation")?.string {
                        words.append(Word(word: word, translation: translation))
                    }
                }
                completion(words)
            case .failure(let error):
                print("查询失败: \(error)")
                completion([])
            }
        }
    }
    
    func addWordToAnotherTable(word: Word, completion: @escaping (Bool) -> Void) {
        let query = "INSERT INTO dailytask (text, translation) VALUES (?, ?)"
        
        // 使用 MySQLData 将字符串转换为适合 MySQL 查询的类型
        let wordData = MySQLData(string: word.word)
        let translationData = MySQLData(string: word.translation)

        connection.query(query, [wordData, translationData]).whenComplete { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print("插入单词失败: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    // 关闭数据库连接，确保所有任务都完成后再关闭
    deinit {
        do {
            try connection.close().wait()
            try eventLoopGroup.syncShutdownGracefully()
        } catch {
            print("关闭数据库连接失败: \(error)")
        }
    }
}
