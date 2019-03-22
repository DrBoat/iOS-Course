//
//  ViewController.swift
//  calculator
//
//  Created by Elliot Alderson on 10/10/2018.
//  Copyright © 2018 Elliot Alderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button_0: UIButton!
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!
    @IBOutlet weak var button_6: UIButton!
    @IBOutlet weak var button_7: UIButton!
    @IBOutlet weak var button_8: UIButton!
    @IBOutlet weak var button_9: UIButton!
    
    @IBOutlet weak var button_comma:    UIButton!
    @IBOutlet weak var button_compute:  UIButton!
    @IBOutlet weak var button_plus:     UIButton!
    @IBOutlet weak var button_minus:    UIButton!
    @IBOutlet weak var button_multiply: UIButton!
    @IBOutlet weak var button_divide:   UIButton!
    @IBOutlet weak var button_sqrt:     UIButton!
    @IBOutlet weak var button_sign:     UIButton!
    @IBOutlet weak var button_clear:    UIButton!
    
    @IBOutlet weak var label_answer: UILabel!
    
    @IBAction func tap_0(_ sender: UIButton)
    {
        tap_number(num: 0)
    }
    @IBAction func tap_1(_ sender: UIButton)
    {
        tap_number(num: 1)
    }
    @IBAction func tap_2(_ sender: UIButton)
    {
        tap_number(num: 2)
    }
    @IBAction func tap_3(_ sender: UIButton)
    {
        tap_number(num: 3)
    }
    @IBAction func tap_4(_ sender: UIButton)
    {
        tap_number(num: 4)
    }
    @IBAction func tap_5(_ sender: UIButton)
    {
        tap_number(num: 5)
    }
    @IBAction func tap_6(_ sender: UIButton)
    {
        tap_number(num: 6)
    }
    @IBAction func tap_7(_ sender: UIButton)
    {
        tap_number(num: 7)
    }
    @IBAction func tap_8(_ sender: UIButton)
    {
        tap_number(num: 8)
    }
    @IBAction func tap_9(_ sender: UIButton)
    {
        tap_number(num: 9)
    }
    
    
    @IBAction func tap_comma(_ sender: UIButton) {
        if (label_answer.text == "Ошибка")
        {
            return
        }
        if(is_double == true || cur_number_string.count >= 9)
        {
            return
        }
        is_double = true
        cur_number_string += "."
        to_label += ","
        label_answer.text = to_label
    }
    
    @IBAction func tap_compute(_ sender: UIButton)
    {
        if (label_answer.text == "Ошибка")
        {
            return
        }
        
        if (!is_exist_frst_num)
        {
            is_exist_frst_num = true
            first_number = cur_number
            new_num()
        }
        else
        {
            if(!is_exist_scnd_num)
            {
                is_exist_scnd_num = true
                second_number = cur_number
                new_num()
            }
            else
            {
                if(!is_exist_thrd_num)
                {
                    is_exist_thrd_num = true
                    third_number = cur_number
                    new_num()
                }
                else
                {
                    precompute();
                    is_exist_thrd_num = true
                    third_number = cur_number
                    new_num()
                }
            }
        }
        
        if (is_exist_thrd_num)
        {
            precompute();
        }
        if (is_exist_scnd_num)
        {
            if (first_action == "plus")
            {
                first_number += second_number;
            }
            else if (first_action == "minus")
            {
                first_number -= second_number;
            }
            else if (first_action == "multiply")
            {
                first_number *= second_number;
            }
            else if (first_action == "divide")
            {
                if (second_number == 0)
                {
                    label_answer.text = "Ошибка"
                    return
                }
                first_number /= second_number;
            }
        }
        var tmp_cur = String(first_number);
        if (tmp_cur.removeLast() == "0")
        {
            if (tmp_cur.removeLast() == ".")
            {
                is_first_double = false
            }
            else
            {
                is_first_double = true
            }
        }
        else
        {
            is_first_double = true
        }
        cur_number = first_number;
        is_double = is_first_double;
        if (!is_first_double)
        {
            cur_number_string = tmp_cur
        }
        else
        {
            cur_number_string = String(cur_number)
        }
        third_number = 0
        is_exist_thrd_num = false
        is_third_double = false
        third_action = ""
        
        if (!is_double)
        {
            if (cur_number_string.count < 9)
            {
                to_label = cur_number_string
                if (to_label.count > 3)
                {
                    to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -3))
                }
                if (to_label.count > 7)
                {
                    to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -7))
                }
                first_number = 0
                is_exist_frst_num = false
                is_first_double = false
                first_action = ""
                second_number = 0
                is_exist_scnd_num = false
                is_second_double = false
                second_action = ""
                third_number = 0
                is_exist_thrd_num = false
                is_third_double = false
                third_action = ""
                label_answer.text = to_label
                is_last_compute = true;
                return
            }
            else
            {
                var cnt = 0
                while (cur_number_string.count > 6)
                {
                    _ = cur_number_string.removeLast()
                    cnt += 1
                }
                cur_number_string += "e"
                cur_number_string += String(cnt)
                label_answer.text = cur_number_string
                first_number = 0
                is_exist_frst_num = false
                is_first_double = false
                first_action = ""
                second_number = 0
                is_exist_scnd_num = false
                is_second_double = false
                second_action = ""
                third_number = 0
                is_exist_thrd_num = false
                is_third_double = false
                third_action = ""
                is_last_compute = true;
                return
            }
        }
        var i = 0;
        var tmp_str = cur_number_string;
        var too_long = true;
        while (i < 9 && cur_number_string.count > 9)
        {
            if (tmp_str.removeFirst() == ".")
            {
                too_long = false;
            }
            i += 1
        }
        if (too_long)
        {
            cur_number_string = String(Int(cur_number))
            var cnt = 0
            while (cur_number_string.count > 6)
            {
                _ = cur_number_string.removeLast()
                cnt += 1
            }
            cur_number_string += "e"
            cur_number_string += String(cnt)
            label_answer.text = cur_number_string
            first_number = 0
            is_exist_frst_num = false
            is_first_double = false
            first_action = ""
            second_number = 0
            is_exist_scnd_num = false
            is_second_double = false
            second_action = ""
            third_number = 0
            is_exist_thrd_num = false
            is_third_double = false
            third_action = ""
            is_last_compute = true;
            return
        }
        else
        {
            while (cur_number_string.count > 9)
            {
                _ = cur_number_string.removeLast()
            }
            cur_number = Double(cur_number_string) ?? 0
            to_label = cur_number_string
            var reversed_end = "";
            while (to_label.last != ".")
            {
                reversed_end += String(to_label.removeLast())
            }
            _ = to_label.removeLast()
            if (to_label.count > 3)
            {
                to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -3))
            }
            if (to_label.count > 7)
            {
                to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -7))
            }
            to_label.insert(",", at: to_label.endIndex)
            while (reversed_end.count > 0)
            {
                to_label.insert(reversed_end.removeLast(), at: to_label.endIndex)
            }
            first_number = 0
            is_exist_frst_num = false
            is_first_double = false
            first_action = ""
            second_number = 0
            is_exist_scnd_num = false
            is_second_double = false
            second_action = ""
            third_number = 0
            is_exist_thrd_num = false
            is_third_double = false
            third_action = ""
            label_answer.text = to_label
            is_last_compute = true;
            return
        }
    }
    
    @IBAction func tap_plus(_ sender: UIButton)
    {
        tap_action(type_of_action: "plus")
    }
    
    @IBAction func tap_minus(_ sender: UIButton)
    {
        tap_action(type_of_action: "minus")
    }
    
    @IBAction func tap_multiply(_ sender: UIButton)
    {
        tap_action(type_of_action: "multiply")
    }
    
    @IBAction func tap_divide(_ sender: UIButton)
    {
        tap_action(type_of_action: "divide")
    }
    
    func tap_action (type_of_action: String)
    {
        if (label_answer.text == "Ошибка")
        {
            return
        }
        if (!is_exist_frst_num)
        {
            is_exist_frst_num = true
            first_number = cur_number
            first_action = type_of_action
            new_num()
        }
        else
        {
            if(!is_exist_scnd_num)
            {
                is_exist_scnd_num = true
                second_number = cur_number
                second_action = type_of_action
                new_num()
            }
            else
            {
                if(!is_exist_thrd_num)
                {
                    is_exist_thrd_num = true
                    third_number = cur_number
                    third_action = type_of_action
                    new_num()
                }
                else
                {
                    precompute();
                    is_exist_thrd_num = true
                    third_number = cur_number
                    third_action = type_of_action
                    new_num()
                }
            }
        }
    }
    
    
    @IBAction func tap_sqrt(_ sender: UIButton)
    {
        if (label_answer.text == "Ошибка")
        {
            return
        }
        if (cur_number < 0)
        {
            label_answer.text = "Ошибка";
            return
        }
        cur_number = cur_number.squareRoot();
        cur_number_string = String(cur_number)
        is_double = check_double_after_sqrt()
        is_last_compute = true;
    }
    
    @IBAction func tap_sign(_ sender: UIButton)
    {
        if (label_answer.text == "Ошибка")
        {
            return
        }
        cur_number *= -1;
        if (cur_number_string.first != "-")
        {
            cur_number_string.insert("-", at: cur_number_string.startIndex)
            to_label.insert("-", at: to_label.startIndex)
            label_answer.text = to_label
        }
        else
        {
            cur_number_string.remove(at: cur_number_string.startIndex)
            to_label.remove(at: to_label.startIndex)
            label_answer.text = to_label
        }
    }
    
    @IBAction func tap_clear(_ sender: UIButton)
    {
        clear()
        label_answer.text = to_label
    }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
    }
    
    
    var first_number: Double = 0
    var is_exist_frst_num = false
    var is_first_double = false
    var first_action = ""
    
    var second_number: Double = 0
    var is_exist_scnd_num = false
    var is_second_double = false
    var second_action = ""
    
    var third_number: Double = 0
    var is_exist_thrd_num = false
    var is_third_double = false
    var third_action = ""
    
    var cur_number:Double = 0
    var cur_number_string = "0"
    var to_label = "0"
    var is_double = false
    var is_last_compute = false;
    
    func clear()
    {
        first_number = 0
        is_exist_frst_num = false
        is_first_double = false
        first_action = ""
        second_number = 0
        is_exist_scnd_num = false
        is_second_double = false
        second_action = ""
        third_number = 0
        is_exist_thrd_num = false
        is_third_double = false
        third_action = ""
        cur_number = 0
        cur_number_string = "0"
        to_label = "0"
        is_double = false
        is_last_compute = false
    }
    
    func new_num()
    {
        cur_number = 0
        cur_number_string = "0"
        to_label = "0"
        is_double = false
        is_last_compute = false
    }
    
    func tap_number(num: Int)
    {
        if (label_answer.text == "Ошибка" || is_last_compute)
        {
            clear()
        }
        if (is_double)
        {
            if (cur_number_string.count >= 10)
            {
                return
            }
            to_label += String(num)
            cur_number_string += String(num)
            cur_number = Double(cur_number_string) ?? cur_number
            label_answer.text = to_label
            return
        }
        if (cur_number_string == "0")
        {
            cur_number_string = "";
        }
        if (cur_number_string.count >= 9)
        {
            return
        }
        cur_number_string += String(num)
        cur_number = Double(cur_number_string) ?? 0
        to_label = cur_number_string
        if (to_label.count > 3)
        {
            to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -3))
        }
        if (to_label.count > 7)
        {
            to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -7))
        }
        
        label_answer.text = to_label
    }
    
    func check_double_after_sqrt() -> Bool
    {
        var tmp_cur = cur_number_string;
        if (tmp_cur.removeLast() == "0")
        {
            if (tmp_cur.removeLast() == ".")
            {
                cur_number_string = tmp_cur
                to_label = cur_number_string
                label_answer.text = to_label
                return false
            }
        }
        while (cur_number_string.count > 9)
        {
            _ = cur_number_string.removeLast()
        }
        cur_number = Double(cur_number_string) ?? 0
        
        to_label = cur_number_string
        var reversed_end = "";
        while (to_label.last != ".")
        {
            reversed_end += String(to_label.removeLast())
        }
        _ = to_label.removeLast()
        if (to_label.count > 3)
        {
            to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -3))
        }
        if (to_label.count > 7)
        {
            to_label.insert(" ", at: to_label.index(to_label.endIndex, offsetBy: -7))
        }
        to_label.insert(",", at: to_label.endIndex)
        while (reversed_end.count > 0) {
            to_label.insert(reversed_end.removeLast(), at: to_label.endIndex)
        }
        label_answer.text = to_label
        return true
    }
    
    func precompute()
    {
        let fs: Bool = (first_action == "plus" || first_action == "minus")
        let ff: Bool = (first_action == "multiply" || first_action == "divide")
        let ss: Bool = (second_action == "plus" || second_action == "minus")
        let sf: Bool = (second_action == "multiply" || second_action == "divide")
        if ((fs && ss) || (ff && sf) || (ff && ss))
        {
            if (first_action == "plus")
            {
                first_number += second_number;
            }
            else if (first_action == "minus")
            {
                first_number -= second_number;
            }
            else if (first_action == "multiply")
            {
                first_number *= second_number;
            }
            else if (first_action == "divide")
            {
                if (second_number == 0)
                {
                    label_answer.text = "Ошибка"
                    return
                }
                first_number /= second_number;
            }
            var tmp_cur = String(first_number);
            if (tmp_cur.removeLast() == "0")
            {
                if (tmp_cur.removeLast() == ".")
                {
                    is_first_double = false
                }
                else
                {
                   is_first_double = true
                }
            }
            else
            {
                is_first_double = true
            }
            second_number = third_number;
            first_action = second_action;
            is_second_double = is_third_double;
            third_number = 0;
            third_action = ""
            is_exist_thrd_num = false
            is_third_double = false
        }
        else
        {
            if (second_action == "plus")
            {
                second_number += third_number;
            }
            else if (second_action == "minus")
            {
                second_number -= third_number;
            }
            else if (second_action == "multiply")
            {
                second_number *= third_number;
            }
            else if (second_action == "divide")
            {
                if (third_number == 0)
                {
                    label_answer.text = "Ошибка"
                    return
                }
                second_number /= third_number;
                
            }
            var tmp_cur = String(second_number);
            if (tmp_cur.removeLast() == "0")
            {
                if (tmp_cur.removeLast() == ".")
                {
                    is_second_double = false
                }
                else
                {
                    is_second_double = true
                }
            }
            else
            {
                is_second_double = true
            }
            second_action = third_action;
            third_number = 0;
            third_action = ""
            is_exist_thrd_num = false
            is_third_double = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label_answer.numberOfLines = 1
        label_answer.adjustsFontForContentSizeCategory = true
        //label_answer.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}
