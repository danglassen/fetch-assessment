//
//  Fetch_AssesmentApp.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import SwiftUI

@main
struct Fetch_AssesmentApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.navigationPath) {
                appCoordinator.start()
            }
        }
    }
}
