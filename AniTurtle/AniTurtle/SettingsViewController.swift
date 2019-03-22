//
//  SettingsViewController.swift
//  AniTurtle
//
//  Created by Elliot Alderson on 05/12/2018.
//  Copyright © 2018 Elliot Alderson. All rights reserved.
//

var settingsSpeed: Int = 50
var settingsDelay: Int = 0
var settingsColor: String = "Green"

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let colorsArray = ["Green", "Blue", "Pink", "Yellow", "Red"]
    
    @IBAction func changeSpeedSlider(_ sender: Any) {
        updateSpeed(speed: Int((speedSliderOutlet?.value)!))
    }
    @IBOutlet weak var speedSliderOutlet: UISlider!
    @IBOutlet weak var speedLabel: UILabel!

    @IBAction func changeDelayStepper(_ sender: Any) {
        updateDelay(delay: Int((delayStepperOutlet?.value)!))
    }
    @IBOutlet weak var delayStepperOutlet: UIStepper!
    @IBOutlet weak var delayLabel: UILabel!
    

    @IBOutlet weak var pickerView: UIPickerView!
    @IBAction func applyColorButton(_ sender: Any) {
        let actualRow = pickerView.selectedRow(inComponent: 0)
        settingsColor = colorsArray[actualRow]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorsArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorsArray[row]
    }
    
    
   
    
    func updateSpeed(speed: Int) {
        speedLabel.text = String(speed)
        settingsSpeed = speed
    }
    
    func updateDelay(delay: Int) {
        delayLabel.text = String(delay)
        settingsDelay = delay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speedSliderOutlet.minimumValue = 1
        speedSliderOutlet.maximumValue = 100
        speedSliderOutlet.value = 50
        updateSpeed(speed: Int((speedSliderOutlet?.value)!))
        
        delayStepperOutlet.minimumValue = 0
        delayStepperOutlet.maximumValue = 5
        delayStepperOutlet.value = 0
        updateDelay(delay: Int((delayStepperOutlet?.value)!))
        
        //pickerView.reloadAllComponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


