import Fluent
import Vapor

func routes(_ app: RoutesBuilder) throws {
    // Static pages
    app.get("", use: HomeController.root)
    app.get(":locale", use: HomeController.root)
    app.get("home", use: HomeController.get)
    app.get(":locale", "home", use: HomeController.get)
}
