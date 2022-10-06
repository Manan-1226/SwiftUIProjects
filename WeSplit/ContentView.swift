//
//  ContentView.swift
//  WeSplit
//
//  Created by Daffolapmac-155 on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double{
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount/100) * tipSelection
        let totalValue = tipValue + checkAmount
        let amountPerPerson = totalValue/peopleCount
        
        return amountPerPerson
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView{
          Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD") )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
               Section{
                   Picker("Tip Percentage", selection: $tipPercentage) {
                       ForEach(tipPercentages, id: \.self){
                           Text($0 , format: .percent)
                       }
                   }
                   .pickerStyle(.segmented)
               } header: {
                   Text("How much tip do you want to leave?")
               }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
          }
          .navigationTitle("WeSplit")
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
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
