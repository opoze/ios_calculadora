//
//  ViewController.swift
//  Calculadora
//
//  Created by Luis Alberto Zagonel Pozenato on 26/05/2019.
//  Copyright © 2019 LuisPozenato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var calculator = Calculator()
    var blink: Bool = false

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var op: UILabel!
    @IBOutlet weak var memory: UILabel!
    @IBOutlet var btns: [UIButton]!
    
    @IBAction func operation(_ button: UIButton) {
        self.blink = true
        switch button.currentTitle {
            case "0","1","2","3","4","5","6","7","8","9":
                self.blink = false
                self.calculator.number(number: button.currentTitle ?? "0")
                break
            case "-":
                self.calculator.sub()
                break
            case "+":
                self.calculator.plus()
                break
            case "÷":
                self.calculator.div()
                break
            case "x":
                self.calculator.mult()
                break
            case "xˆ2":
                self.calculator.pot()
                break
            case "√":
                self.calculator.squareRoot()
                break
            case "=":
                self.calculator.equal()
                break
            case ",":
                self.blink = false
                self.calculator.dot()
                break
            case "C":
                self.calculator.cleanAll()
                break
            case "-/+":
                self.blink = false
                self.calculator.togglePositive()
                break
            default:
                break
        }
        self.updateViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in btns {
            btn.layer.cornerRadius = 10
        }
    }
    
    func updateViewModel(){
        // if display value has changed, then blink
        if self.blink {
            self.display.startBlink()
        }
        self.display.text = self.calculator.display
        self.op.text = self.calculator.operationType
        self.memory.text = String(self.calculator.memory)
    }
}

