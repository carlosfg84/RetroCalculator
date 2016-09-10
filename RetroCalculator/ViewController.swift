//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Carlos Flores Guardado on 9/1/16.
//  Copyright © 2016 Carlos Flores Guardado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
   

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = "0"
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var equalpressed: Bool = false
    var firstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        playSound()
        processOperation(Operation.Multiply)

    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        playSound()
        processOperation(Operation.Substract)

    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        processOperation(Operation.Add)

    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        playSound()
        processOperation(currentOperation)
        equalpressed = true
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        if firstTime == true {
            runningNumber = ""
            runningNumber += "\(btn.tag)"
            outputLbl.text = runningNumber
            firstTime = false
        } else {
            runningNumber += "\(btn.tag)"
            outputLbl.text = runningNumber
        }
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        initialize()
        equalpressed = false
        outputLbl.text = "0"
    }
    

    func processOperation (op: Operation) {
        if equalpressed == false {
            if currentOperation != Operation.Empty {
                    rightValStr = runningNumber
                    if currentOperation == Operation.Add {
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    } else if currentOperation == Operation.Substract {
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    } else if currentOperation == Operation.Multiply {
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    } else if currentOperation == Operation.Divide {
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    }
                    outputLbl.text = result
                    leftValStr = result
                    runningNumber = ""
                    currentOperation = op
            }
            else {
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = op
            }
        } else {
            currentOperation = op
            equalpressed = false
        }
    }

    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func initialize() {
        currentOperation = Operation.Empty
        runningNumber = "0"
        leftValStr = ""
        rightValStr = ""
        result = ""
        firstTime = true
    }
}

