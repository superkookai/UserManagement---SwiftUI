//
//  ContentView.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var showAddUser = false
    @State private var showConfirmDialog = false
    @State private var id: Int = 0
    @State private var name: String = ""
    @State private var showEditUser = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(userVM.users, id: \.id){ user in
                    HStack{
                        Text(user.name)
                        Spacer()
                        Text("\(user.id!)")
                    }
                    .onTapGesture {
                        showConfirmDialog = true
                        self.id = user.id!
                        self.name = user.name
                    }
                }
                .confirmationDialog("Delete or Edit?", isPresented: $showConfirmDialog) {
                    
                    Button("Delete", role: .destructive) {
                        userVM.deleteUser(id: self.id)
                        userVM.getUsers()
                        showConfirmDialog = false
                    }
                    
                    Button("Edit", role: .none) {
                        showEditUser = true
                        showConfirmDialog = false
                    }
                    
                    Button("Cancel", role: .cancel) {
                        showConfirmDialog = false
                    }
                }
            }
            .onAppear(perform: {
                userVM.getUsers()
            })
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddUser.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $showAddUser) {
                AddUserView()
                    .environmentObject(userVM)
                    .presentationDetents([.height(250)])
            }
            .sheet(isPresented: $showEditUser) {
                EditUserView(id: self.id, name: self.$name)
                    .environmentObject(userVM)
                    .presentationDetents([.height(250)])
            }
        }
    }
}

#Preview {
    UserListView()
}
