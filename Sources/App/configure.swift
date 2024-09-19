import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    let queueTimesApi = QueueTimesApi(client: app.client)
    
    try app.register(collection: ParksInfoController(queueTimes: queueTimesApi))

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
