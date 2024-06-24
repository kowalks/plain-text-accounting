//
//  plain_text_accountingApp.swift
//  plain-text-accounting
//
//  Created by Guilherme Kowalczuk on 23/06/24.
//

import SwiftUI

@main
struct plain_text_accountingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
