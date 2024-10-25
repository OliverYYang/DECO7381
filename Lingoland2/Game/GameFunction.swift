import Foundation
import MySQLNIO
import NIO

func connectToDatabase() -> EventLoopFuture<MySQLConnection> {
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    let address = try! SocketAddress.makeAddressResolvingHost("35.244.90.249", port: 3306)
    
    return MySQLConnection.connect(
        to: address,
        username: "deco7381northwind",
        database: "deco7381northwind",
        password: "123456",
        tlsConfiguration: nil,
        on: eventLoopGroup.next()
    )
}

// 从数据库获取随机的单词及其翻译
func fetchRandomReviewAndTranslations() -> EventLoopFuture<(String, [String], String)> {
    return connectToDatabase().flatMap { conn in
        // 查询随机的一条记录
        let query = """
        SELECT text, translation
        FROM dailytask
        ORDER BY RAND()
        LIMIT 1
        """
        
        return conn.query(query).flatMap { rows in
            if let row = rows.first {
                let text = row.column("text")?.string ?? ""
                let correctTranslation = row.column("translation")?.string ?? ""

                let randomTranslationsQuery = """
                SELECT translation
                FROM dailytask
                WHERE translation != ?
                ORDER BY RAND()
                LIMIT 3
                """
                
                return conn.query(randomTranslationsQuery, [MySQLData(string: correctTranslation)]).flatMap { randomRows in
                    var options = randomRows.compactMap { $0.column("translation")?.string }
                    options.append(correctTranslation)
                    options.shuffle()
                    return conn.close().map {
                        return (text, options, correctTranslation)
                    }
                }
            } else {
                return conn.eventLoop.makeFailedFuture(NSError(domain: "DatabaseError", code: 404, userInfo: nil))
            }
        }.flatMapError { error in
            return conn.close().flatMap {
                return conn.eventLoop.makeFailedFuture(error)
            }
        }
    }
}


func generateNewQuestion(completion: @escaping (String, [String], String) -> Void) {
    fetchRandomReviewAndTranslations().whenSuccess { text, options, correctTranslation in
        completion(text, options, correctTranslation)
    }
}


func checkAnswer(selectedOption: String, correctAnswer: String, correctTranslation: String) -> Bool {
    return selectedOption == correctTranslation
}

func gainExp(currentEXP: inout Int, currentLevel: inout Int) {
    currentEXP += 5
    if currentEXP >= 10 {
        currentLevel += 1
        currentEXP = 0
    }
}

func healCharacter(currentHP: inout Int, cost: inout Int) {
    if cost >= 5 {
        cost -= 5
        currentHP += 5
    }
}

func handleCorrectAnswer(monsterHP: inout Int, playerCost: inout Int) {
    monsterHP -= 1
    playerCost += 1
}

