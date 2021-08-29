//
//  ViewController.swift
//  AmILucky
//
//  Created by Ahmet Engin Gökçe on 22.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var finalScore1: UILabel!
    @IBOutlet weak var finalScore2: UILabel!
    @IBOutlet weak var avatar1: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var setScore1: UILabel!
    @IBOutlet weak var setScore2: UILabel!
    @IBOutlet weak var status1: UIImageView!
    @IBOutlet weak var status2: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var setPoints = (setPoint1 : 0, setPoint2 : 0)
    var finalPoints = (finalPoint1 : 0, finalPoint2 : 0)
    var playerTurn : Int = 1
    var currentSet : Int = 1
    var maxSet : Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if currentSet > maxSet {
            if finalPoints.finalPoint1 > finalPoints.finalPoint2 {
                resultLabel.text = "Game Over. 1. Player Win"
            } else {
                resultLabel.text = "Game Over. 2. Player Win"
            }
            return
        }
        createDices()
    }
    
    func resultOfSet(dice1 : Int, dice2 : Int) {
        if playerTurn == 1 {
            setPoints.setPoint1 = dice1 + dice2
            setScore1.text = "\(setPoints.setPoint1)"
            status1.image = UIImage(named: "wait")
            status2.image = UIImage(named: "go")
            resultLabel.text = "2. Player Turn"
            playerTurn = 2
            setScore2.text = "0"
        } else {
            setPoints.setPoint2 = dice1 + dice2
            setScore2.text = "\(setPoints.setPoint2)"
            status1.image = UIImage(named: "go")
            status2.image = UIImage(named: "wait")
            resultLabel.text = "1.Player Turn"
            playerTurn = 1
            if setPoints.setPoint1 > setPoints.setPoint2 {
                finalPoints.finalPoint1 += 1
                finalScore1.text = "\(finalPoints.finalPoint1)"
                resultLabel.text = "1. Player Win \n1.Player Turn"
                currentSet += 1
            } else if setPoints.setPoint1 < setPoints.setPoint2 {
                finalPoints.finalPoint2 += 1
                finalScore2.text = "\(finalPoints.finalPoint2)"
                resultLabel.text = "2. Player Win \n1. Player Turn"
                currentSet += 1
            } else {
                resultLabel.text = "Scoreless"
            }
        }
    }

    func createDices() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            self.imgDice1.image = UIImage(named: String(dice1))
            self.imgDice2.image = UIImage(named: String(dice2))
            self.resultOfSet(dice1: Int(dice1), dice2: Int(dice2))
        }
        resultLabel.text = "\(playerTurn). Player Rolling the Dices"
        imgDice1.image = UIImage(named: "rollingDices")
        imgDice2.image = UIImage(named: "rollingDices")
    }

}

