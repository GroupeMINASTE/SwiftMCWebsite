//
//  SwiftMCWebsite.swift
//  
//
//  Created by Nathan Fallet on 04/07/2022.
//

import SwiftMC
import Vapor

public class SwiftMCWebsite {

    // Static instance
    public static let instance = SwiftMCWebsite()

    // Services
    public let swiftmc: SwiftMC
    public let vapor: Application

    // Initializer
    internal init() {
        // Get server folder
        guard let folder = URL(string: FileManager.default.currentDirectoryPath) else {
            exit(-1)
        }

        // Initialize SwiftMC
        self.swiftmc = SwiftMC(serverRoot: folder.appendingPathComponent("swiftmc").path)

        // Initialize Vapor
        var env = try! Environment.detect()
        try! LoggingSystem.bootstrap(from: &env)
        self.vapor = Application(env)

        do {
            try configure(vapor)
        } catch {
            print(error.localizedDescription)
        }

        // TODO: Use plugin system
        self.enable(server: swiftmc)
    }

    // Start the service
    public func start() {
        // Start SwiftMC
        DispatchQueue.global().async {
            self.swiftmc.start()
            exit(0)
        }

        // Start Vapor
        DispatchQueue.global().async {
            do{
                try self.vapor.run()
            } catch {
                print(error.localizedDescription)
            }
        }

        // Listen for commands
        while let input = readLine(strippingNewline: true) {
            self.swiftmc.dispatchCommand(command: input)
        }
    }

    public func enable(server: SwiftMC) {
        // Register events
        

        // Register commands
        
    }

}
