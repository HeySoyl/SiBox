//
//  24-03-20-CreateDescriptionTable.swift
//  App
//
//  Created by Soyl on 2020/3/24.
//

import Fluent
import FluentPostgreSQL

extension Description: Migration {
    static func prepare( on connection: PostgreSQLConnection ) -> Future<Void>
    {
        return Database.create(Description.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert(
        on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.delete(Description.self, on: connection)
    }
}
