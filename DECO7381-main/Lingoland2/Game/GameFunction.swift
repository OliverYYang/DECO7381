import Foundation
import MySQLNIO
import NIO

// 数据库连接信息配置
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

                // 查询三个随机的翻译，不包括正确的翻译
                let randomTranslationsQuery = """
                SELECT translation
                FROM dailytask
                WHERE translation != ?
                ORDER BY RAND()
                LIMIT 3
                """
                
                return conn.query(randomTranslationsQuery, [MySQLData(string: correctTranslation)]).flatMap { randomRows in
                    var options = randomRows.compactMap { $0.column("translation")?.string }
                    options.append(correctTranslation)  // 插入正确的翻译
                    options.shuffle()  // 随机打乱顺序
                    return conn.close().map { // 在返回之前关闭连接
                        return (text, options, correctTranslation)  // 返回问题、选项和正确翻译
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


// 生成新的问题和选项
func generateNewQuestion(completion: @escaping (String, [String], String) -> Void) {
    fetchRandomReviewAndTranslations().whenSuccess { text, options, correctTranslation in
        completion(text, options, correctTranslation)  // 返回问题、选项和正确翻译
    }
}


// 检查答案是否正确
func checkAnswer(selectedOption: String, correctAnswer: String, correctTranslation: String) -> Bool {
    return selectedOption == correctTranslation
}

// 增加经验并升级
func gainExp(currentEXP: inout Int, currentLevel: inout Int) {
    currentEXP += 5
    if currentEXP >= 10 {
        currentLevel += 1
        currentEXP = 0 // 重置经验值
    }
}

// 治疗角色
func healCharacter(currentHP: inout Int, cost: inout Int) {
    if cost >= 5 {
        cost -= 5
        currentHP += 5
    }
}

// 减少怪物HP并增加玩家cost
func handleCorrectAnswer(monsterHP: inout Int, playerCost: inout Int) {
    monsterHP -= 1
    playerCost += 1
}

