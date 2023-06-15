//
//  EmployeePreviewData.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import Foundation

extension URL {
    static let employeeTest = Bundle.main.url(forResource: "EmpleadosTest", withExtension: "json")!
}

final class TestPersistance: NetworkPersistance {
    
    func getEmployees() async throws -> [Employee] {
        let data = try Data(contentsOf: .employeeTest)
        return try JSONDecoder().decode([Employee].self, from: data)
    }
}

extension EmployeeListViewModel {
    static let employeeTestVM = EmployeeListViewModel(persistance: TestPersistance())
}

extension Employee {
    static let testEmployee = Employee(id: 2000, firstName: "David", username: "Bisbi", lastName: "Bisbal", avatar: URL(string: "https://img1.picmix.com/output/stamp/normal/4/8/8/6/1676884_119bf.png")!, email: "bisbi@gmail.com", department: Department(id: 1, name: .marketing), gender: Gender(id: 1, gender: .female), address: "Calle garcia")
}
