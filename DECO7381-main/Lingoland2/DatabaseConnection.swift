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
    ).flatMap { connection in
        print("Successfully connected to the database.")  // 成功连接时输出
        return connection.eventLoop.makeSucceededFuture(connection)
    }.flatMapError { error in
        print("Failed to connect to the database: \(error.localizedDescription)")  // 连接失败时输出
        return eventLoopGroup.next().makeFailedFuture(error)
    }
}

