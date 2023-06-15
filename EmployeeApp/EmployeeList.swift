//
//  ContentView.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import SwiftUI

struct EmployeeList: View {
    @ObservedObject var vm: EmployeeListViewModel
    @State var showAddEmployee = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(DepartmentName.allCases) { dpto in
                    Section(dpto.rawValue) {
                        ForEach(vm.filteredEmployees) { employee in
                            if employee.department.name == dpto {
                                EmployeeCell(employee: employee)
                            }
                        }
                    }
                }
            }
            .searchable(text: $vm.search, placement: .automatic, prompt: "Search an Employee")
            .alert(isPresented: $vm.showError) {
                Alert(title: Text("An error has ocurred"), message: Text(vm.errorMessage), dismissButton: .default(Text("Cerrar")))
            }
            .animation(.spring(), value: vm.search)
            .navigationTitle("Employees")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddEmployeeView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}


struct EmployeeList_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeList(vm: .employeeTestVM)
    }
}
