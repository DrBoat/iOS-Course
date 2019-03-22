//
//  ViewController.swift
//  AniTurtle
//
//  Created by Elliot Alderson on 28/11/2018.
//  Copyright © 2018 Elliot Alderson. All rights reserved.
//

import UIKit

class TurtleViewController: UIViewController {
    
    var onStart: Bool = true
    
    public func updateTurtlesColor(color: String) {
        let imageName = color + "TurtleImage";
        changeTurtleColor (image: UIImage (named: imageName)!)
    }
    
    func changeTurtleColor(image: UIImage) {
        fstTurtle.image = image
        sndTurtle.image = image
        trdTurtle.image = image
        fthTurtle.image = image
    }
    
    func animateTurtles(image: UIImageView, option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 50.0 / Double(settingsSpeed), delay: Double(settingsDelay), options: [option],
            animations: {
                let lenOfScreen: CGFloat = CGFloat(UIScreen.main.bounds.size.width) - CGFloat(30) - CGFloat(image.frame.width)
                image.center.x += lenOfScreen
                
        })
    }
    
    func returnTurtles(image: UIImageView) {
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveLinear],
                       animations: {
                        let lenOfScreen: CGFloat = CGFloat(UIScreen.main.bounds.size.width) - CGFloat(30) - CGFloat(image.frame.width)
                        image.center.x -= lenOfScreen
                        
        })
    }
    
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var returnButtonOutlet: UIButton!
    @IBAction func startButton(_ sender: Any) {
        returnButton(returnButtonOutlet)
        onStart = false
        animateTurtles(image: fstTurtle, option: UIView.AnimationOptions.curveLinear)
        animateTurtles(image: sndTurtle, option: UIView.AnimationOptions.curveEaseIn)
        animateTurtles(image: trdTurtle, option: UIView.AnimationOptions.curveEaseOut)
        animateTurtles(image: fthTurtle, option: UIView.AnimationOptions.curveEaseInOut)
        
    }
    @IBAction func returnButton(_ sender: Any) {
        if (!onStart) {
            onStart = true
            returnTurtles(image: fstTurtle)
            returnTurtles(image: sndTurtle)
            returnTurtles(image: trdTurtle)
            returnTurtles(image: fthTurtle)
            
        }
    }
    @IBOutlet weak var fstTurtle: UIImageView!
    @IBOutlet weak var sndTurtle: UIImageView!
    @IBOutlet weak var trdTurtle: UIImageView!
    @IBOutlet weak var fthTurtle: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTurtlesColor(color: settingsColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTurtlesColor(color: settingsColor)
    }
    
    

}

