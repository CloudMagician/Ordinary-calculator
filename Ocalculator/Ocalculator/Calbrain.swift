//
//  Calbrain.swift
//  Ocalculator
//
//  Created by 陆子旭 on 2018/5/20.
//  Copyright © 2018年 jetfire lu. All rights reserved.
//

import Foundation

struct CalBrain
{
    private var accumlator : Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equal
        case clear
    }
    
    private var operations : Dictionary<String,Operation> = [
        "π":Operation.constant(Double.pi),
        "e":Operation.constant(M_E),
        "√":Operation.unaryOperation(sqrt),
        "sin":Operation.unaryOperation(sin),
        "cos":Operation.unaryOperation(cos),
        "tan":Operation.unaryOperation(tan),
        "±":Operation.unaryOperation({ -$0 }),
        "+":Operation.binaryOperation({ $0+$1 }),
        "-":Operation.binaryOperation({ $0-$1 }),
        "×":Operation.binaryOperation({ $0*$1 }),
        "÷":Operation.binaryOperation({ $0/$1 }),
        "=":Operation.equal,
        "C":Operation.clear,
        ]
    
    mutating func performOperation(_ symbol : String){
        
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumlator = value
            case .unaryOperation(let function):
                if let operand = accumlator{
                    accumlator = function(operand)
                }
            case .binaryOperation(let function):
                if accumlator != nil{
                    if pbo != nil {
                        accumlator = pbo?.performOperation(with: accumlator!)
                    }
                    pbo = PendingBinaryOperation(firstOperand: accumlator!, function: function)
                }
            case .equal:
                if accumlator != nil && pbo != nil {
                    accumlator = pbo?.performOperation(with: accumlator!)
                    pbo = nil
                }
            case .clear:
                accumlator = 0
                pbo = nil
            }
        }
    }
    
    private var pbo:PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        var firstOperand:Double
        var function: (Double,Double)->Double
        
        func performOperation(with secondOperand:Double)->Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand : Double){
        accumlator = operand
    }
    
    var result : Double?{
        get{
            return accumlator!
        }
    }
}
