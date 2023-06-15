//
//  EmployeeListVM.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import Foundation

final class EmployeeListViewModel: ObservableObject {
    let persistance: NetworkPersistance
    
    @Published var employees: [Employee] = []
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var search = ""
    @Published var department: [Department] = []
    
    var filteredEmployees: [Employee] {
        employees.filter { employee in
            searchFilter(employee: employee)
        }
    }
    
    init(persistance: NetworkPersistance = Persistance.shared) {
        self.persistance = persistance
        Task {
            await getEmployees()
        }
    }

    @MainActor
    private func getEmployees() async {
        do {
            employees = try await persistance.getEmployees()
        } catch let error as NetworkErrors {
            errorMessage = error.rawValue
            showError = true
            print(error.rawValue)
            employees = []
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            print(error)
            employees = []
        }
    }
    
    private func searchFilter(employee: Employee) -> Bool {
        search.isEmpty || employee.firstName.lowercased().contains(search.lowercased())
    }
}
