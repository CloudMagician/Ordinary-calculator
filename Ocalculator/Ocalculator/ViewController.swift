//
//  ViewController.swift
//  Ocalculator
//
//  Created by 陆子旭 on 2018/5/20.
//  Copyright © 2018年 jetfire lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var display: UILabel!
    
    private var userIsTyping = false
    
    @IBAction func bottom(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            if display.text!.count < 10 {
                display.text = display.text! + digit
            }
        }else {
            if digit != "0" {
                display.text = digit
                userIsTyping = true
            }
        }
    }
    
    private var IsPointFlag = false
    
    @IBAction func PointFlag(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            if !display.text!.contains(".") {
                display.text = display.text! + digit
            }
        }else {
            display.text = "0" + digit
            userIsTyping = true
        }
    }
    
    func CorrectOutput(_ Number: String) -> String {
        var result = Number
        if Number.hasSuffix(".0") {
            result.removeLast(2)
        }
        return result
    }
    
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = CorrectOutput(String(newValue))
        }
    }
    
    private var brain = CalBrain()
    
    @IBAction func performOperration(_ sender: UIButton) {
        userIsTyping = false
        
        if let symbol = sender.currentTitle{
            brain.setOperand(displayValue)
            brain.performOperation(symbol)
        }
        if let value = brain.result {
            displayValue = value
        }
    }
}
