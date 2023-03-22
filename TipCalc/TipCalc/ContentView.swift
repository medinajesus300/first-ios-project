//
//  ContentView.swift
//  PlayAround
//
//  Created by Jesus Medina on 3/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var amountOfPeople: Int = 1
    @State private var percent: Int = 10
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson : Double  {
        
        let personCount = Double(amountOfPeople + 2)
        let tipSelected = Double(percent)
        
        let tipValue = checkAmount / 100 * tipSelected
        let result = checkAmount + tipValue
        let amountPerPerson = result / personCount
        
        return amountPerPerson
    }
    
    let percentOptions: Array<Int> = [10, 20, 30, 40, 50]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                    
                    Picker("Number of People: ", selection: $amountOfPeople) {
                        ForEach(2..<15) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section{
                    Picker("Percentage", selection: $percent) {
                        ForEach(percentOptions, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
        
}

