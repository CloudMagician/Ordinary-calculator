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
    
    var userIsTyping = false
    
    @IBAction func bottom(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
        }else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
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

