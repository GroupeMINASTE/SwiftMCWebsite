//
//  SessionTimeoutMiddleware.swift
//  
//
//  Created by Nathan Fallet on 04/07/2022.
//

import Vapor

struct SessionTimeoutMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        request.session.data["lastRequest"] = String(Date().timeIntervalSince1970)
        return next.respond(to:request)
    }
    
}
