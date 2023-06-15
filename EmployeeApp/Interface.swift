//
//  Interface.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import Foundation

let mainURL = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!

enum HTTTMethods: String {
    case get = "GET"
    case post = "POST"
}

extension URL {
    static let getEmployees = mainURL.appending(path: "getEmpleados")
    static let postEmployee = mainURL.appending(path: "empleado")
    static let getDepartments = mainURL.appending(path: "getDepartamentos")
}

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTTMethods.get.rawValue
        request.timeoutInterval = 20
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    static func post<JSON:Codable>(url: URL, data: JSON) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTTMethods.post.rawValue
        request.timeoutInterval = 20
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
}
