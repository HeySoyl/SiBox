import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Register the configured PostgreSQL database to the database config.
    let databaseConfig: PostgreSQLDatabaseConfig
    let hostname: String = "127.0.0.1"
    let username: String = "postgres"
    let database: String = "postgres"
    let password: String = "postgres"
    let port: Int = 54322
    
    if let url = Environment.get("DATABASE_URL") {
        // configuring database
        databaseConfig = PostgreSQLDatabaseConfig(url: url, transport: .unverifiedTLS)!
    } else {
        databaseConfig = PostgreSQLDatabaseConfig(
            hostname: hostname,
            port: port,
            username: username,
            database: database,
            password: password,
            transport: .unverifiedTLS
        )
    }
    let postgresql = PostgreSQLDatabase(config: databaseConfig)
    var databases = DatabasesConfig()
    databases.add(database: postgresql, as: .psql)
    services.register(databases)

    // Configure migrations
    DrugInfo.defaultDatabase = .psql
    var migrations = MigrationConfig()
    migrations.add(model: DrugInfo.self, database: .psql)
    migrations.add(model: Description.self, database: .psql)
    
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
