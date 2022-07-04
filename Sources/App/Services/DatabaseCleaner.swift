//
//  DatabaseCleaner.swift
//  
//
//  Created by Nathan Fallet on 04/07/2022.
//

import Vapor
import Fluent

struct DatabaseCleaner: LifecycleHandler {
    
    func didBoot(_ application: Application) throws {
        // Delete sessions older than 24h
        let now = Date().timeIntervalSince1970
        let _ = SessionRecord.query(on: application.db)
            .all()
            .mapEachCompact { session -> SessionID? in
                let lastRequest = Double(session.data["lastRequest"] ?? "0") ?? 0
                if now - lastRequest > 24 * 3600 {
                    let _ = session.delete(on: application.db)
                    return nil
                } else {
                    return session.key
                }
            }
    }
    
}
