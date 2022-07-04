//
//  HomeController.swift
//  
//
//  Created by Nathan Fallet on 04/07/2022.
//

import Vapor
import SwiftMC

class HomeController {
    
    static func root(_ request: Request) throws -> Response {
        let path = request.url.path.hasSuffix("/") ? request.url.path : (request.url.path + "/")
        return request.redirect(to: path + "home")
    }
    
    static func get(_ request: Request) throws -> EventLoopFuture<View> {
        let homeContext = HomeContext(
            description: try request.application.lingoVapor.lingo().localize("home_description", locale: request.locale),
            canonical: "/home",
            serverInfo: SwiftMCWebsite.instance.swiftmc.getServerInfo(preferedProtocol: ProtocolConstants.minecraft_1_18.rawValue)
        )
        
        return request.view.render("home", homeContext)
    }
    
}

struct HomeContext: Codable {
    
    var description: String
    var canonical: String
    var serverInfo: ServerInfo
    
}
