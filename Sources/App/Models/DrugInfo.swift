import FluentPostgreSQL
import Fluent
import Foundation
import Vapor

/// A single entry of a DrugInfo list.
final class DrugInfo: Content, PostgreSQLModel {
    
    /// The unique identifier for this `DrugInfo`.
    var id: Int?
    var name: String?
    var image: String?
    var drugCode: Int?
    var category: Int?    //1: H化学药品，2： Z中药，3: S生物制品，4: B保健药品，5: T体外化学诊断试剂，6: F药用辅料，7: J进口分包装药品
    var isHome: Bool?     //国产药 true: 国产药 flase: 进口药
    var isOTC: Bool?      //是否为OTC true: OTC flase: 非OTC
    var uuid: UUID?
    var descriptionID: Description.ID?

    /// Creates a new `DrugInfo`.
    init(id: Int?, name: String?, image: String?, drugCode: Int?, category: Int?, isHome: Bool?, isOTC: Bool?, descriptionID: Description.ID?, uuid: UUID?) {
        self.id = id
        self.name = name
        self.image = image
        self.drugCode = drugCode
        self.category = category
        self.isHome = isHome
        self.isOTC = isOTC
        self.descriptionID = descriptionID
        self.uuid = UUID()
    }
}

///// Allows `DrugInfo` to be used as a dynamic migration.
//extension DrugInfo: Migration { }

/// Allows `DrugInfo` to be encoded to and decoded from HTTP messages.
//extension DrugInfo: Content { }

/// Allows `DrugInfo` to be used as a dynamic parameter in route definitions.
extension DrugInfo: Parameter { }

extension DrugInfo {
    var druges: Parent<DrugInfo, Description> {
        return parent(\.descriptionID)!
    }
}
