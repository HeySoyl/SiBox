import FluentSQLite
import Vapor

/// A single entry of a DrugInfo list.
final class DrugInfo: Content, SQLiteModel {
    
    /// The unique identifier for this `DrugInfo`.
    var id: Int?
    var name: String
    var image: Data

    /// Creates a new `DrugInfo`.
    init(id: Int? = nil, name: String, image: Data) {
        self.id = id
        self.name = name
        self.image = image
    }
}

/// Allows `DrugInfo` to be used as a dynamic migration.
extension DrugInfo: Migration { }

/// Allows `DrugInfo` to be encoded to and decoded from HTTP messages.
//extension DrugInfo: Content { }

/// Allows `DrugInfo` to be used as a dynamic parameter in route definitions.
extension DrugInfo: Parameter { }