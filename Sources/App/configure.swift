import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    //定义mysql数据库配置参数的变量
    let mysqlHost: String
    let mysqlPort: Int
    let mysqlDB: String
    let mysqlUser: String
    let mysqlPass: String
    if env == .development || env == .testing {
        //线下环境使用的配置信息
        mysqlHost = "127.0.0.1"
        mysqlPort = 3306
        mysqlDB = "SiBox"
        mysqlUser = "liaozesong"
        mysqlPass = "Lzslov123!"
    }
    else {
        //生产环境，读取机器配置的配置，如果读取失败，则取默认值
        mysqlHost = Environment.get("MYSQL_HOST") ?? "127.0.0.1"
        mysqlPort = 3306
        mysqlDB = Environment.get("MYSQL_DB") ?? "SiBox"
        mysqlUser = Environment.get("MYSQL_USER") ?? "liaozesong"
        mysqlPass = Environment.get("MYSQL_PASS") ?? "Lzslov123!"
    }
    
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: mysqlHost,
        port: mysqlPort,
        username: mysqlUser,
        password: mysqlPass,
        database: mysqlDB,
        transport: .unverifiedTLS)
    
    let mysql = MySQLDatabase(config: mysqlConfig)
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    // Configure migrations
    DrugInfo.defaultDatabase = .mysql
    var migrations = MigrationConfig()
    migrations.add(model: DrugInfo.self, database: .mysql)
    
//    //开发环境填充测试数据
//    if env == .development {
//        migrations.add(migration: DrugInfoSeeder.self, database: .mysql)
//    }
    services.register(migrations)
    
    /**
     # 注册migrations命令
     - vapor run migrate: 执行migrate创建表，并执行seed构建测试数据
     - vapor run revert -all: 依照migrate创建表顺序，依次清空表数据后删除该表
     */
    var commandConfig = CommandConfig.default()
    commandConfig.useFluentCommands()
    services.register(commandConfig)
}
