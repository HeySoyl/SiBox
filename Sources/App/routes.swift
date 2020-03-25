import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    try router.register(collection: DrugInfoController())
    try router.register(collection: DescriptionController())
    
    
    
    // "It works" page
    router.get { req in
        return try req.view().render("welcome")
    }
    
    // Says hello
    router.get("hello1", String.parameter) { req -> Future<View> in
        return try req.view().render("hello", [
            "name": req.parameters.next(String.self)
        ])
    }

    router.get("hello") { req -> Future<View> in
        return try req.view().render("hello", ["name": "Leaf"])
    }
    
//    // Basic "It works" example
//    router.get { req in
//        return "It works!"
//    }
//
//    // Basic "Hello, world!" example
//    router.get("hello") { req in
//        return "Hello, world!"
//    }
//
//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}
