//
//  ViewController.swift
//  calculator
//
//  Created by Elliot Alderson on 10/10/2018.
//  Copyright © 2018 Elliot Alderson. All rights reserved.
//

import UIKit

enum ActionType {
    case plus
    case minus
    case multiply
    case divide
    case nothing
}

class ViewController: UIViewController {
    var firstNumber: Double = 0
    var isFirstNumExists = false
    var isFirstDouble = false
    var firstAction = ActionType.nothing
    
    var secondNumber: Double = 0
    var isSecondNumExists = false
    var isSecondDouble = false
    var secondAction = ActionType.nothing
    
    var thirdNumber: Double = 0
    var isThirdNumExists = false
    var isThirdDouble = false
    var thirdAction = ActionType.nothing
    
    var currentNumber:Double = 0
    var curentNumberString = "0"
    var toLabel = "0"
    var isDouble = false
    var isLastComputed = false
    
    func softClear(){
        firstNumber = 0
        isFirstNumExists = false
        isFirstDouble = false
        firstAction = ActionType.nothing
        secondNumber = 0
        isSecondNumExists = false
        isSecondDouble = false
        secondAction = ActionType.nothing
        thirdNumber = 0
        isThirdNumExists = false
        isThirdDouble = false
        thirdAction = ActionType.nothing
    }
    
    func clear() {
        softClear()
        currentNumber = 0
        curentNumberString = "0"
        toLabel = "0"
        isDouble = false
        isLastComputed = false
    }
    
    @IBOutlet weak var labelAnswer: UILabel!
    
    @IBAction func tap0(_ sender: UIButton) {
        tapNumber(num: 0)
    }
    @IBAction func tap1(_ sender: UIButton) {
        tapNumber(num: 1)
    }
    @IBAction func tap2(_ sender: UIButton) {
        tapNumber(num: 2)
    }
    @IBAction func tap3(_ sender: UIButton) {
        tapNumber(num: 3)
    }
    @IBAction func tap4(_ sender: UIButton) {
        tapNumber(num: 4)
    }
    @IBAction func tap5(_ sender: UIButton) {
        tapNumber(num: 5)
    }
    @IBAction func tap6(_ sender: UIButton) {
        tapNumber(num: 6)
    }
    @IBAction func tap7(_ sender: UIButton) {
        tapNumber(num: 7)
    }
    @IBAction func tap8(_ sender: UIButton) {
        tapNumber(num: 8)
    }
    @IBAction func tap9(_ sender: UIButton) {
        tapNumber(num: 9)
    }
    
    @IBAction func tapComma(_ sender: UIButton) {
        if (labelAnswer.text == "Ошибка" ||
            isDouble == true ||
            curentNumberString.count >= 9) {
            return
        }
        
        isDouble = true
        curentNumberString += "."
        toLabel += ","
        labelAnswer.text = toLabel
    }
    
    @IBAction func tapCompute(_ sender: UIButton) {
        if (labelAnswer.text == "Ошибка") {
            return
        }
        newNumber()
        
        if (isThirdNumExists) {
            precompute()
        }
        
        let copyOfFirstNumber = computeFirstAction()
        currentNumber = firstNumber
        isDouble = isFirstDouble
        
        thirdNumber = 0
        isThirdNumExists = false
        isThirdDouble = false
        thirdAction = ActionType.nothing
        
        if (isDouble) {
            curentNumberString = String(currentNumber)
        } else {
            curentNumberString = copyOfFirstNumber
            if (curentNumberString.count < 9) {
                toLabel = curentNumberString
                setSpacesToLabel()
                labelAnswer.text = toLabel
                isLastComputed = true
                softClear()
                return
            } else {
                toExpForm()
                return
            }
        }
        var i = 0
        var copyOfCurrentNumberString = curentNumberString
        var isTooLong = true
        
        while (i < 9 && curentNumberString.count > 9) {
            if (copyOfCurrentNumberString.removeFirst() == ".") {
                isTooLong = false
            }
            i += 1
        }
        if (isTooLong) {
            curentNumberString = String(Int(currentNumber))
            toExpForm()
            return
        } else {
            recalculateSpacesForDouble()
            isLastComputed = true
            softClear()
            return
        }
    }
    
    @IBAction func tapPlus(_ sender: UIButton) {
        newNumber(actionType: .plus)
    }
    
    @IBAction func tapMinus(_ sender: UIButton) {
        newNumber(actionType: .minus)
    }
    
    @IBAction func tapMultiply(_ sender: UIButton) {
        newNumber(actionType: .multiply)
    }
    
    @IBAction func tapDivide(_ sender: UIButton) {
        newNumber(actionType: .divide)
    }
    
    func newNumber (actionType: ActionType = .nothing) {
        if (labelAnswer.text == "Ошибка") {
            return
        }
        if (!isFirstNumExists) {
            isFirstNumExists = true
            firstNumber = currentNumber
            if (actionType != .nothing) {
                firstAction = actionType
            }
            toNextNumber()
        } else {
            if(!isSecondNumExists) {
                isSecondNumExists = true
                secondNumber = currentNumber
                if (actionType != .nothing) {
                    secondAction = actionType
                }
                toNextNumber()
            } else {
                if(!isThirdNumExists) {
                    isThirdNumExists = true
                    thirdNumber = currentNumber
                    if (actionType != .nothing) {
                        thirdAction = actionType
                    }
                    toNextNumber()
                } else {
                    precompute()
                    isThirdNumExists = true
                    thirdNumber = currentNumber
                    if (actionType != .nothing) {
                        thirdAction = actionType
                    }
                    toNextNumber()
                }
            }
        }
    }
    
    
    @IBAction func tapSqrt(_ sender: UIButton) {
        if (labelAnswer.text == "Ошибка") {
            return
        }
        if (currentNumber < 0) {
            labelAnswer.text = "Ошибка"
            return
        }
        currentNumber = currentNumber.squareRoot()
        curentNumberString = String(currentNumber)
        isDouble = checkDoubleAfterSqrt()
        isLastComputed = true
    }
    
    @IBAction func tapSign(_ sender: UIButton) {
        if (labelAnswer.text == "Ошибка") {
            return
        }
        currentNumber *= -1
        if (curentNumberString.first != "-") {
            curentNumberString.insert("-", at: curentNumberString.startIndex)
            toLabel.insert("-", at: toLabel.startIndex)
            labelAnswer.text = toLabel
        } else {
            curentNumberString.remove(at: curentNumberString.startIndex)
            toLabel.remove(at: toLabel.startIndex)
            labelAnswer.text = toLabel
        }
    }
    
    @IBAction func tapClear(_ sender: UIButton) {
        clear()
        labelAnswer.text = toLabel
    }
    
    @IBAction func swipe(_ sender: UIGestureRecognizer) {
        if (labelAnswer.text == "Ошибка" || isLastComputed) {
            clear()
        }
        if (curentNumberString == "0") {
            return
        }
        if (isDouble && curentNumberString.last == "." && toLabel.last == ",") {
                isDouble = false
        }
        _ = curentNumberString.removeLast()
        _ = toLabel.removeLast()
        
        if (!isDouble) {
            toLabel = curentNumberString
            setSpacesToLabel()
        }
        labelAnswer.text = toLabel
    }
    
    func toNextNumber() {
        currentNumber = 0
        curentNumberString = "0"
        toLabel = "0"
        isDouble = false
        isLastComputed = false
    }
    
    func tapNumber(num: Int) {
        if (labelAnswer.text == "Ошибка" || isLastComputed) {
            clear()
        }
        if (isDouble) {
            if (curentNumberString.count >= 10) {
                return
            }
            toLabel += String(num)
            curentNumberString += String(num)
            currentNumber = Double(curentNumberString) ?? currentNumber
            labelAnswer.text = toLabel
            return
        }
        if (curentNumberString == "0") {
            curentNumberString = ""
        }
        if (curentNumberString.count >= 9) {
            return
        }
        curentNumberString += String(num)
        currentNumber = Double(curentNumberString) ?? 0
        toLabel = curentNumberString
        setSpacesToLabel()
        labelAnswer.text = toLabel
    }
    
    func checkDoubleAfterSqrt() -> Bool {
        var copyOfCurrentNumberString = curentNumberString
        if (copyOfCurrentNumberString.removeLast() == "0") {
            if (copyOfCurrentNumberString.removeLast() == ".") {
                curentNumberString = copyOfCurrentNumberString
                toLabel = curentNumberString
                labelAnswer.text = toLabel
                return false
            }
        }
        recalculateSpacesForDouble()
        return true
    }
    
    func precompute() {
        /// first letter: number of action
        /// second letter: priority of action
        let fs: Bool = (firstAction == .plus || firstAction == .minus)
        let ff: Bool = (firstAction == .multiply || firstAction == .divide)
        let ss: Bool = (secondAction == .plus || secondAction == .minus)
        let sf: Bool = (secondAction == .multiply || secondAction == .divide)
        
        if ((fs && ss) || (ff && sf) || (ff && ss)) {
            _ = computeFirstAction()
            secondNumber = thirdNumber
            firstAction = secondAction
            isSecondDouble = isThirdDouble
            thirdNumber = 0
            thirdAction = .nothing
            isThirdNumExists = false
            isThirdDouble = false
        } else {
            computeSecondAction()
            secondAction = thirdAction
            thirdNumber = 0
            thirdAction = .nothing
            isThirdNumExists = false
            isThirdDouble = false
        }
    }
    
    func computeFirstAction() -> String {
        if (isFirstNumExists && isSecondNumExists) {
            switch firstAction {
            case .plus: do {
                self.firstNumber += secondNumber
                }
            case .minus: do {
                self.firstNumber -= secondNumber
            }
            case .multiply: do {
                self.firstNumber *= secondNumber
            }
            case .divide: do {
                if (self.secondNumber == 0) {
                    labelAnswer.text = "Ошибка"
                    return ""
                }
                self.firstNumber /= secondNumber
            }
            case .nothing: do {}
            }
        }
        
        isFirstDouble = true
        var copyOfFirstNumber = String(firstNumber)
        if (copyOfFirstNumber.removeLast() == "0") {
            if (copyOfFirstNumber.removeLast() == ".") {
                isFirstDouble = false
            }
        }
        return copyOfFirstNumber
    }
    
    func computeSecondAction() {
        if (isSecondNumExists && isThirdNumExists) {
            switch secondAction {
            case .plus: do {
                self.secondNumber += thirdNumber
                }
            case .minus: do {
                self.secondNumber -= thirdNumber
            }
            case .multiply: do {
                self.secondNumber *= thirdNumber
            }
            case .divide: do {
                if (self.thirdNumber == 0) {
                    labelAnswer.text = "Ошибка"
                    return
                }
                self.secondNumber /= thirdNumber
            }
            case .nothing: do {}
            }
        }
        
        isSecondDouble = true
        var copyOfSecondNumber = String(secondNumber)
        if (copyOfSecondNumber.removeLast() == "0") {
            if (copyOfSecondNumber.removeLast() == ".") {
                isSecondDouble = false
            }
        }
    }
    
    func toExpForm() {
        var cnt = 0
        while (curentNumberString.count > 6) {
            _ = curentNumberString.removeLast()
            cnt += 1
        }
        if (cnt > 0) {
            curentNumberString.insert(",", at: curentNumberString.index(curentNumberString.startIndex, offsetBy: 1))
            while (curentNumberString.last == "0") {
                _ = curentNumberString.removeLast()
            }
            if (curentNumberString.last == ",") {
                _ = curentNumberString.removeLast()
            }
            curentNumberString += "e"
            curentNumberString += String(cnt + 5)
        }
        labelAnswer.text = curentNumberString
        isLastComputed = true
        softClear()
    }
    
    func setSpacesToLabel() {
        if (toLabel.count > 6) {
            toLabel.insert(" ", at: toLabel.index(toLabel.endIndex, offsetBy: -6))
        }
        if (toLabel.count > 3) {
            toLabel.insert(" ", at: toLabel.index(toLabel.endIndex, offsetBy: -3))
        }
    }
    
    func recalculateSpacesForDouble() {
        while (curentNumberString.count > 9) {
            _ = curentNumberString.removeLast()
        }
        currentNumber = Double(curentNumberString) ?? 0
        
        toLabel = curentNumberString
        var reversedEnd = ""
        while (toLabel.last != ".") {
            reversedEnd += String(toLabel.removeLast())
        }
        _ = toLabel.removeLast()
        setSpacesToLabel()
        toLabel.insert(",", at: toLabel.endIndex)
        while (reversedEnd.count > 0) {
            toLabel.insert(reversedEnd.removeLast(), at: toLabel.endIndex)
        }
        labelAnswer.text = toLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelAnswer.numberOfLines = 1
        labelAnswer.adjustsFontForContentSizeCategory = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}
