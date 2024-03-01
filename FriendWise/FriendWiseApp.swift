//
//  FriendWiseApp.swift
//  FriendWise
//
//  Created by ramsayleung on 2024-02-28.
//

import SwiftUI
import SwiftData

@main
struct FriendWiseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self])
    }
}
