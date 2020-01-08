//
//  ViewController.swift
//  BullsEye
//
//  Created by Jose Kappert on 11/12/2019.
//  Copyright © 2019 Jose Kappert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var roundNumber = 0
    
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for:.normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for:.highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert(){
        
        let difference = abs(targetValue - currentValue)
        var points : Int
        
        
        if difference == 0{
            points = 100 - difference + 100
        }else if difference == 1{
            points = 100 - difference + 50
        }else{
            points = 100 - difference
        }
        
        score+=points
        
        let title: String
        if difference == 0{
            title = "Perfect!"
        }else if difference < 5 {
            title = "You almost had it!"
        }else if difference < 10 {
            title = "Pretty good!"
        }else{
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
//        startNewRound()

    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
     func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    @IBAction func restartGame(){
        roundNumber = 0
        score = 0
        startNewRound()
    }
    
    func updateLabels(){
        roundNumber+=1
        roundLabel.text = String(roundNumber)
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
    }
    
}
