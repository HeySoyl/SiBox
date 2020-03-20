import FluentPostgreSQL
import Fluent
import Foundation
import Vapor

/// A single entry of a DrugInfo list.
final class DrugInfo: Content, PostgreSQLModel {
    
    /// The unique identifier for this `DrugInfo`.
    var id: Int?
    var name: String
    var image: String
    var drugCode: String
    var category: Int    //1: 化学药品，2： 中药，3: 生物制品，4: 辅料，
    var isHome: Bool    //国产药 true: 国产药 flase: 进口药
    var isOTC: Bool    //是否为OTC true: OTC flase: 非OTC
    var uuid: UUID?

    /// Creates a new `DrugInfo`.
    init(id: Int? = nil, name: String, image: String, drugCode: String, category: Int, isHome: Bool, isOTC: Bool, uuid: UUID? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.drugCode = drugCode
        self.category = category
        self.isHome = isHome
        self.isOTC = isOTC
        self.uuid = UUID()
    }
}

///// Allows `DrugInfo` to be used as a dynamic migration.
//extension DrugInfo: Migration { }

/// Allows `DrugInfo` to be encoded to and decoded from HTTP messages.
//extension DrugInfo: Content { }

/// Allows `DrugInfo` to be used as a dynamic parameter in route definitions.
extension DrugInfo: Parameter { }
