//
//  UserViewModel.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import SwiftUI

@MainActor
class UserViewModel: ObservableObject{
    @Published var users: [User] = []
    @Published var errorMessage = ""
    
    func getUsers(){
        NetworkManager.share.getUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let users):
                self.users = users
            case .failure(let errorMessage):
                self.errorMessage = errorMessage.rawValue
            }
        }
    }
    
    func addUser(name: String, age: Int){
        NetworkManager.share.addUser(name: name, age: age)
    }
    
    func deleteUser(id: Int){
        NetworkManager.share.deleteUser(id: id)
    }
    
    func editUser(id: Int, name: String){
        NetworkManager.share.editUser(id: id, name: name)
    }
}
