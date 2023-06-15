//
//  EmployeeAppApp.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import SwiftUI

@main
struct EmployeeAppApp: App {
    var body: some Scene {
        WindowGroup {
            EmployeeList(vm: EmployeeListViewModel())
            //AddEmployeeView()
        }
    }
}
