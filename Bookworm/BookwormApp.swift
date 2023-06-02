//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Uriel Ortega on 30/05/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // Injecting dataController into the environment.
        }
    }
}
