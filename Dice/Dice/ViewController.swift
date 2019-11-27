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
    var diceCount = 0
    let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    @IBOutlet var dices: [UIImageView]!
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var diceCountLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var shakeButtonOutlet: UIButton!
    
    @IBAction func stepperAction(_ sender: Any) {
        reloadDiceCounter()
        diceCount = Int(stepperOutlet!.value)
    }
    @IBAction func shakeButton(_ sender: Any) {
        print("SHAKE button pressed")
        shakeDice()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {}
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Device shaked")
            shakeDice()
        }
    }
    
    func reloadDiceCounter() {
        let newValue = Int(stepperOutlet!.value)
        let oldValue = diceCount
        if (newValue > oldValue) {
            changeDiceValue(diceNum: newValue)
        }
        if (newValue < oldValue) {
            changeDiceValue(diceNum: oldValue, value: 0)
        }
        diceCountLabel.text = String(newValue) + " DICE"
        print("diceCount changed from", oldValue, "to", newValue)
    }
    
    func shakeDice() {
        utilityQueue.async {
            self.animateDices()
        }
    }
    
    func animateDices() {
        var time = 2000000, delay = 1000 // in microseconds
        
        while (time > 0)
        {
            print("Animate. Time left:", time, "microseconds")
            for i in 1...diceCount {
                self.changeDiceValue(diceNum: i)
            }
            reloadDiceSum()
            usleep(useconds_t(delay))
            delay *= 2
            time -= delay
        }
        print("Animate ended")
    }
    
    func changeDiceValue (diceNum:Int, value:Int = .random(in: 1...6)) {
        DispatchQueue.main.async {
            let imageName = "diceValue" + String(value);
            self.dices[diceNum - 1].image = UIImage(named: imageName)
        }
        diceValues[diceNum - 1] = value
        print("Dice number", String(diceNum), "is", String(value))
    }
    
    func reloadDiceSum() {
        let sum = diceValues.reduce(0, +)
        DispatchQueue.main.async {
            self.sumLabel.text = "Sum = " + String(sum)
        }
        print("Dice sum is", String(sum))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stepperOutlet.minimumValue = 1
        stepperOutlet.maximumValue = 6
        diceCount = 2
        stepperOutlet.value = Double(diceCount)
        changeDiceValue(diceNum: 1)
        changeDiceValue(diceNum: 2)
    }


}

