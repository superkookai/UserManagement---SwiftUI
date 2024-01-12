//
//  UserManagementApp.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import SwiftUI

@main
struct UserManagementApp: App {
    @StateObject var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            UserListView()
                .environmentObject(userVM)
        }
    }
}
