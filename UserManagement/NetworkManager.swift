//
//  NetworkManager.swift
//  UserManagement
//
//  Created by Weerawut Chaiyasomboon on 12/1/2567 BE.
//

import Foundation

enum ErrorMessage: String, Error{
    case invalidUrl = "Invalid URL. Please check"
    case invalidResponse = "Response Error. Please check."
    case invalidData = "Data Error. Please check."
}

class NetworkManager{
    static let share = NetworkManager()
    private init () {}
    
    let baseUrl = "http://localhost:8080/"
    
    func getUsers(completed: @escaping (Result<[User], ErrorMessage>)->Void){
        let endpoint = baseUrl + "api/users"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completed(.failure(.invalidUrl))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                completed(.success(users))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func addUser(name: String, age: Int){
        let endpoint = baseUrl + "api/users"
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let user = User(name: name, age: age)
        let data = try! JSONEncoder().encode(user)
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        
        task.resume()
    }
    
    func deleteUser(id: Int){
        let endpoint = baseUrl + "api/users/\(id)"
        
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
//        request.setValue(
//            "application/json",
//            forHTTPHeaderField: "Content-Type"
//        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        
        task.resume()
    }
    
    func editUser(id: Int, name: String){
        let endpoint = baseUrl + "api/users/\(id)"
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let user = User(name: name)
        let data = try! JSONEncoder().encode(user)
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        
        task.resume()
    }
}
