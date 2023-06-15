//
//  EmployeeCell.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 5/6/23.
//

import SwiftUI

struct EmployeeCell: View {
    let employee: Employee
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(employee.fullName)
                    .font(.headline)
                Text(employee.email)
                    .font(.caption)
            }
            
            Spacer()
            AsyncImage(url: employee.avatar) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
        }
    }
}

struct EmployeeCell_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCell(employee: .testEmployee)
            .padding()
    }
}
