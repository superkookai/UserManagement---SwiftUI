//
//  EditUserView.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import SwiftUI

struct EditUserView: View {
    var id: Int
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var name: String
    
    var body: some View {
        VStack{
            Text("Edit User")
            
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                userVM.editUser(id: id, name: name)
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
    EditUserView(id: 1, name: .constant("Kai"))
}
