//
//  Persistance.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import Foundation

enum NetworkErrors: String, Error {
    case badResponse = "Cannot convert response to HTTPURLResponse"
    case notFound = "URL Not found"
    case serverNotFound = "Server Not Found"
    case unknown = "Unknown Error"
    case badParse = "Failed to parse data"
}

protocol NetworkPersistance {
    func getEmployees() async throws -> [Employee]
 }

final class Persistance: NetworkPersistance {
    static let shared = Persistance()
    
    private init(){}
    
    func getEmployees() async throws -> [Employee] {
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getEmployees))
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.badResponse
        }
        
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode([Employee].self, from: data)
            } catch {
                throw NetworkErrors.badParse
            }
        case 400...450:
            throw NetworkErrors.notFound
        case 500...550:
            throw NetworkErrors.serverNotFound
        default:
            throw NetworkErrors.unknown
        }
    }
    
    func getDepartments() async throws -> [Department] {
        let (data, response) = try await URLSession.shared.data(for: .get(url: .getDepartments))
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.badResponse
        }
        
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode([Department].self, from: data)
            } catch {
                throw NetworkErrors.badParse
            }
        case 400...450:
            throw NetworkErrors.notFound
        case 500...550:
            throw NetworkErrors.serverNotFound
        default:
            throw NetworkErrors.unknown
        }
    }
    
    func postEmployee(employee: NewEmployee) async {
        let (_, response) = try! await URLSession.shared.data(for: .post(url: .postEmployee, data: employee))
        
        if let urlResponse = response as? HTTPURLResponse {
        #if DEBUG
            debugPrint(urlResponse.statusCode)
        #endif
        }
    }
}
