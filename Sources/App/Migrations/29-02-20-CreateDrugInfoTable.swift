//
//  29-02-20-CreateDrugInfoTable.swift
//  App
//
//  Created by Soyl on 2020/2/29.
//

import Fluent
import FluentMySQL

extension DrugInfo: Migration {
    static func prepare( on connection: MySQLConnection ) -> Future<Void>
    {
        return Database.create(DrugInfo.self, on: connection){
            builder in
            try addProperties(to: builder)
        }
    }
    static func revert(
        on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(DrugInfo.self, on: connection)
    }
}
