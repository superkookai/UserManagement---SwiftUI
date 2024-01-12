//
//  AddUserView.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import SwiftUI

struct AddUserView: View {
    @State private var name: String = ""
    @State private var age: Int = 0
    
    @EnvironmentObject var userVM: UserViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Add User")
            
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            TextField("Age", value: $age, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            Button(action: {
                userVM.addUser(name: name, age: age)
                userVM.getUsers()
                dismiss()
            }, label: {
                Text("Submit")
            })
        }
        .padding()
    }
}

#Preview {
    AddUserView()
}
