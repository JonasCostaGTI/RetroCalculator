//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Jonas Costa on 02/02/17.
//  Copyright © 2017 Jonas Costa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    
    //ao carrega a tela
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = "0"
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer.init(contentsOf: soundURL)
            btnSound.prepareToPlay()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        playSound()
        clearText(sender: sender as! UIButton)
    }
    
    
    //sound on press
    func playSound(){
        
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != ""{
                rightValueString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                    
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                    
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                    
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLbl.text = result
        }
            
            currentOperation = operation
        }else{
            //this is the first time an operator has been pressed
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
}
    
    func clearText(sender: UIButton){
        runningNumber = "\(sender.tag)"
        processOperation(operation: Operation.Empty)
        outputLbl.text = "0"
    }

}


