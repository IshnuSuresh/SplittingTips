//
//  ContentView.swift
//  SplittingTips
//
//  Created by Ishnu Suresh on 2023-06-23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.00
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
            
            let tipSelection = Double(tipPercentage)
            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            
            return grandTotal
        }
        
        var body: some View {
            NavigationStack {
                Form {
                    Section {
                        
                        TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How much do you want to tip?")
                    }
                    
                    
                    Section {
                        Text(totalAmount, format: .currency(code: "USD"))
                    } header: {
                        Text("Grand Total")
                    }
                    
                    
                    Section {
                        Text(totalPerPerson, format: .currency(code: "USD"))
                    } header: {
                        Text("Total per Person")
                    }
                }
                .navigationBarTitle("Splitting Tips")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        
                        Spacer()
                        
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            }
            .navigationTitle("Splitting Tips")
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
