import FluentPostgreSQL
import Vapor

/// A single entry of a DrugInfo list.
final class DrugInfo: Content, PostgreSQLModel {
    
    /// The unique identifier for this `DrugInfo`.
    var id: Int?
    var name: String
    var image: String

    /// Creates a new `DrugInfo`.
    init(id: Int? = nil, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

///// Allows `DrugInfo` to be used as a dynamic migration.
//extension DrugInfo: Migration { }

/// Allows `DrugInfo` to be encoded to and decoded from HTTP messages.
//extension DrugInfo: Content { }

/// Allows `DrugInfo` to be used as a dynamic parameter in route definitions.
extension DrugInfo: Parameter { }
