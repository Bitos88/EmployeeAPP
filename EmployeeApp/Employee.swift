//
//  Empleado.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import Foundation

struct Employee: Codable, Identifiable, Hashable {
    let id: Int
    let firstName: String
    let username: String
    let lastName: String
    let avatar: URL
    let email: String
    let department: Department
    let gender: Gender
    let address: String
    
    var fullName: String {
        "\(lastName), \(firstName)"
    }
}

struct NewEmployee: Codable {
    let username:String
    let firstName:String
    let lastName:String
    let email:String
    let address:String
    let avatar:String?
    let zipcode:String?
    let department:Int
    let gender:Int
    
    static var emptyEmployee: NewEmployee {
        NewEmployee(username: "", firstName: "", lastName: "", email: "", address: "", avatar: "", zipcode: "", department: 1, gender: 1)
    }
}

struct Department: Codable, Identifiable, Hashable {
    let id: Int
    let name: DepartmentName
}

enum DepartmentName: String, Codable, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
}

struct Gender: Codable, Identifiable, Hashable {
    let id: Int
    let gender: GenderName
}

enum GenderName: String, Codable, CaseIterable, Identifiable {
    var id: Int {
        switch self {
        case .female:
            return 2
        case .male:
            return 1
        }
    }
    case female = "Female"
    case male = "Male"
}
