//
//  Calculator.swift
//  Calculadora
//
//  Created by Luis Alberto Zagonel Pozenato on 27/05/2019.
//  Copyright © 2019 LuisPozenato. All rights reserved.
//

import Foundation

class Calculator {
    
    var display: String = ""
    var operationType: String = ""
    var memory: Double = 0.0
    let limit: Int = 100
    var hasFloatingPoint: Bool = false
    var hasMemory: Bool = false
    var canCleanDisplay: Bool = false
    var error: Bool = false
    
    // Basic Operations
    func function(operation op: String) {
        self.startOperation(operation: op)
    }
    
    func plus() {
        self.startOperation(operation: "+")
    }
    
    func sub() {
        self.startOperation(operation: "-")
    }
    
    func mult() {
        self.startOperation(operation: "x")
    }
    
    func div() {
        self.startOperation(operation: "/")
    }
    
    // Advanced operations
    func squareRoot() {
        self.startOperation(operation: "square")
        self.equal()
    }
    
    func pot() {
        self.startOperation(operation: "pow")
        self.equal()
    }
    
    // Edit
    func number(number num: String) {
        self.displayAppend(character: num)
    }
    
    func dot(){
        if !self.hasFloatingPoint{
            self.displayAppend(character: ",")
            self.hasFloatingPoint = true
        }
    }
    
    // Computes de result
    func equal() {
        if self.display != "", !self.error {
            var result: Double = Double(self.display.replacingOccurrences(of: ",", with: ".")) ?? 0.0
            if self.hasMemory {
                if self.operationType == "+" {
                    result += self.memory
                }
                if self.operationType == "-" {
                    result = self.memory - result
                }
                if self.operationType == "x" {
                    result *= self.memory
                }
                if self.operationType == "/", self.memory != 0.0 { // prevent zero division
                    result /= self.memory
                }
                
                if self.operationType == "square" {
                    result = self.memory.squareRoot()
                }
                if self.operationType == "pow" {
                    result = pow(self.memory, 2)
                }
                
                if "\(result)".count > 20 {
                    self.error = true
                    self.display = "Error..."
                }
                else{
                    self.toDisplay(value: result)
                    self.memory = result
                }
            }
        }
    }
    
    func displayAppend(character char: String) {
        // Reset error
        if self.error {
            self.cleanAll()
        }
        if self.display.count < self.limit {
            if self.canCleanDisplay {
                self.cleanDisplay()
            }
            // if display is 0 then dont append, just override
            if self.display == "0" {
                if char == "," {
                    self.display = "0,"
                }
                else {
                    self.display = char
                }
            }
            else {
                self.display.append(char)
            }
        }
    }
    
    func startOperation(operation op: String){
        // Has display data?
        if self.display != "", !self.error {
            // Put actual display value on memory
            self.displayToMemory()
            // Save operation type
            self.operationType = op
            // Once a operation is started, the next number will clean the display
            self.canCleanDisplay = true
        }
    }
    
    func displayToMemory() {
        self.memory = Double(self.display.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        self.hasMemory = true
    }
    
    func toDisplay(value val: Double) {
        // Get the decimal part of memory to check if need to format string end put a colon
        if val.truncatingRemainder(dividingBy: 1) <= 0 {
            self.display = "\(val)".replacingOccurrences(of: ".0", with: "")
        }
        else {
            self.display = "\(val)".replacingOccurrences(of: ".", with: ",")
        }
    }
    
    func togglePositive() {
        let value = Double(self.display.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        if value > 0 {
            self.display = "-\(self.display)"
        }
        else {
            self.display = self.display.replacingOccurrences(of: "-", with: "")
        }
    }
    
    func cleanDisplay(){
        self.display = ""
        self.hasFloatingPoint = false
        self.canCleanDisplay = false
    }
    
    func cleanMemory() {
        self.memory = 0.0
        self.hasMemory = false
    }
    
    func cleanOperation() {
        self.operationType = ""
    }
    
    func cleanAll() {
        self.error = false
        self.cleanDisplay()
        self.cleanMemory()
        self.cleanOperation()
        self.number(number: "0")
    }
}
