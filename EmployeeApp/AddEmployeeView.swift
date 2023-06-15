//
//  AddEmployeeView.swift
//  EmployeeApp
//
//  Created by Alberto Alegre Bravo on 4/6/23.
//

import SwiftUI

struct AddEmployeeView: View {
    @ObservedObject var vm = AddEmployeeViewModel()
    @FocusState var focusField: AddEmployeeFields?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("First Name")
                        .font(.headline)
                    TextField("Enter first name", text: $vm.firstName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .focused($focusField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                        
                }
                
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.headline)
                    TextField("Enter last name", text: $vm.lastName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .focused($focusField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("User Name")
                    TextField("Enter user name", text: $vm.userName)
                        .textContentType(.username)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                        .keyboardType(.default)
                        .focused($focusField, equals: .userName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Enter your email", text: $vm.email)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .focused($focusField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Address")
                    TextField("Enter your Address", text: $vm.address)
                        .textContentType(.fullStreetAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                        .focused($focusField, equals: .address)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Zip Code")
                    TextField("Enter your Zip Code", text: $vm.zipcode)
                        .textContentType(.postalCode)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                        .focused($focusField, equals: .zipcode)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                
                Picker(selection: $vm.gender) {
                    ForEach(GenderName.allCases) { genre in
                        Text(genre.rawValue)
                            .tag(genre)
                    }
                } label: {
                    Text("Gender")
                }
                
                Picker(selection: $vm.department) {
                    ForEach(vm.departamentos) { dpto in
                        Text(dpto.name.rawValue)
                            .tag(dpto.id)
                    }
                } label: {
                    Text("Department")
                }
            }
            .navigationTitle("New Employee")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.postEmployee()
                    if vm.dismissView {
                        dismiss()
                        vm.cleanFields()
                    }
                    
                } label: {
                    Text("Save")
                }
                .alert(isPresented: $vm.showWrongFieldAlert) {
                    Alert(title: Text("Something went wrong"), message: Text(vm.wrongFieldMessage))
                }
            }
        }
        .textFieldStyle(.roundedBorder)
    }
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddEmployeeView()
        }
    }
}
