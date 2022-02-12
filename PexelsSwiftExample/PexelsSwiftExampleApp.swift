//
//  PexelsSwiftExampleApp.swift
//  PexelsSwiftExample
//
//  Created by Alex Nagy on 12.02.2022.
//

import SwiftUI
import pexels_swift

@main
struct PexelsSwiftExampleApp: App {
    
    init() {
        PexelsApp.configure(apiKey: "563492ad6f917000010000010501645b0f7748b081eb1326aee1d9c2", logLevel: .debug)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
