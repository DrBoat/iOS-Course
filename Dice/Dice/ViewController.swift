//
//  ViewController.swift
//  Dice
//
//  Created by Elliot Alderson on 12/12/2018.
//  Copyright © 2018 Elliot Alderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var diceValues = [0, 0, 0, 0, 0, 0]
    
    
    @IBOutlet var dices: [UIImageView]!
    
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var diceCountLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var shakeButtonOutlet: UIButton!
    
    @IBAction func stepperAction(_ sender: Any) {
        reloadDiceCounter(Int(stepperOutlet!.value))
    }
    @IBAction func shakeButton(_ sender: Any) {
        shakeDice()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {}
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shakeDice()
        }
    }
    
    func shakeDice() {
        animateDices()
//        print("Shaked")
    }
    
    func reloadDiceCounter(_ newValue:Int) {
        let oldValue = Int(String((diceCountLabel.text?.prefix(1))!))!
        if (newValue > oldValue) {
            changeDiceValue(diceNum: newValue, value: Int.random(in: 1...6))
        }
        if (newValue < oldValue) {
            changeDiceValue(diceNum: oldValue, value: 0)
        }
        diceCountLabel.text = String(newValue) + " DICE"
    }
    
    func changeDiceValue (diceNum:Int, value:Int) {
        let imageName = "diceValue" + String(value);
        diceValues[diceNum - 1] = value
        
//        DispatchQueue.main.async(execute: {
            self.dices[diceNum - 1].image = UIImage(named: imageName)
//        })
        
//        print("Dice number " + String(diceNum) + " is " +  String(value))
        reloadDiceValues()
    }
    
    func animateDices(/*time:Int, delay: Int*/) {
//        var time:Int = 5000000
//        var delay:Int = 1000
        let diceCount = Int(String((diceCountLabel.text?.prefix(1))!))!
//        while (time > 0)
//        {
            for i in 1...diceCount {
                changeDiceValue(diceNum: i, value: Int.random(in: 1...6))
            }
//            print(time)
//            usleep(useconds_t(delay))
//            delay *= 2
//            time -= delay
//        }
    }

    func reloadDiceValues() {
        let sum = diceValues.reduce(0, +)
        sumLabel.text = "Sum = " + String(sum)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepperOutlet.minimumValue = 1
        stepperOutlet.maximumValue = 6
        stepperOutlet.value = 2
        changeDiceValue(diceNum: 1, value: Int.random(in: 1...6))
        changeDiceValue(diceNum: 2, value: Int.random(in: 1...6))
    }


}

