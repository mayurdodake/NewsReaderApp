//
//  NewsReaderApp.swift
//  NewsReader
//
//  Created by Mayur on 09/11/24.
//

import SwiftUI

@main
struct NewsReaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NewsListView()
        }
    }
}
