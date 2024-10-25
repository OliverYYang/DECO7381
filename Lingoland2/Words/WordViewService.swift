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
            
            // Configure the database connection
            self.connection = try MySQLConnection.connect(
                to: address,
                username: "deco7381northwind",
                database: "deco7381northwind",
                password: "123456",
                tlsConfiguration: nil,
                on: eventLoopGroup.next()
            ).wait()
        } catch {
            print("Failed to connect to the database: \(error.localizedDescription)")
            fatalError("Unable to connect to the database: \(error)")
        }
    }

    // Method to fetch words
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
                print("Query failed: \(error)")
                completion([])
            }
        }
    }
    
    func addWordToAnotherTable(word: Word, completion: @escaping (Bool) -> Void) {
        let query = "INSERT INTO dailytask (text, translation) VALUES (?, ?)"
        
        // Use MySQLData to convert strings to MySQL-compatible data types
        let wordData = MySQLData(string: word.word)
        let translationData = MySQLData(string: word.translation)

        connection.query(query, [wordData, translationData]).whenComplete { result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print("Failed to insert word: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    // Close the database connection, ensuring all tasks are completed before closing
    deinit {
        do {
            try connection.close().wait()
            try eventLoopGroup.syncShutdownGracefully()
        } catch {
            print("Failed to close the database connection: \(error)")
        }
    }
}

