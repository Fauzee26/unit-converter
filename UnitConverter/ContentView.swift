//
//  ContentView.swift
//  UnitConverter
//
//  Created by Muhammad Hilmy Fauzi on 06/11/22.
//

import SwiftUI

extension Unit {
    var asString: String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        
        return formatter.string(from: self).capitalized
    }
}

struct ContentView: View {
    @State private var unitInput = UnitLength.meters
    @State private var unitOutput = UnitLength.meters
    @State private var lengthInput = 0.0
    @FocusState private var inputIsFocused: Bool
    
    let unitOptions: [UnitLength] = [
        .meters,
        .kilometers,
        .feet,
        .yards,
        .miles,
        .inches,
        .fathoms,
        .hectometers,
        .scandinavianMiles
    ]
    
    var lengthConverted: String {
        let inputMeasurement = Measurement(value: lengthInput, unit: unitInput)
        let outputMeasurement = inputMeasurement.converted(to: unitOutput)
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        formatter.unitOptions = .providedUnit
        
        let outputValue = formatter.string(from: outputMeasurement)
        
        return outputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Length", value: $lengthInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Input Type", selection: $unitInput) {
                        ForEach(unitOptions, id: \.self) {
                            Text("\($0.asString)")
                        }
                    }
                    Picker("Output Type", selection: $unitOutput) {
                        ForEach(unitOptions, id: \.self) {
                            Text("\($0.asString)")
                        }
                    }
                } header: {
                    Text("Unit Selection")
                }
                
                Section {
                    Text(lengthConverted)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
