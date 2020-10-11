//
//  ViewController.swift
//  Set-Final
//
//  Created by Dhananjay Pahuja on 10/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    var set: Game = Game()
    var cardsModel: CardsModel = CardsModel()
    var currentSet: [Int] = []
    
    var scoreCount = 0 {
        didSet {
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var renderedCards: Int = 0      //on screen counter
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: Any) {
        
        set = Game()
        scoreCount = 0
        resetSet()
        
        if deal3.isHidden == true{          //enable deal 3 more cards button
            deal3.isHidden = false
            deal3.isUserInteractionEnabled = true
        }
        
        loadViewUI()
    }
    
        //array
    
    //    @IBOutlet var cardButtons: [UIButton] = {
    //        var buttons: [UIButton]
    //    }()
    
   
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        let indexOfCard = cardButtons.firstIndex(of: sender)
        
        if indexOfCard! >= set.countOnScreenCard() {
            return
        }
        
        if currentSet.count == 3 {
            resetSet()
        }
        
        set.selectCard(index: indexOfCard!)
        touchedAgain(index: indexOfCard!)
        checkMatch()
        scoreCount = set.returnScore()
    }
    
    
    func touchedAgain(index: Int) {
        for i in 0..<currentSet.count {
            if currentSet[i] == index {
                cardButtons[index].layer.borderWidth = 0.0
                cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                cardButtons[index].layer.cornerRadius = 0.0
                currentSet.remove(at: i)
                return
            }
        }
        
        cardButtons[index].layer.borderWidth = 3.0
        cardButtons[index].layer.borderColor = UIColor.cyan.cgColor
        cardButtons[index].layer.cornerRadius = 7.0
        currentSet.append(index)
    }
    
    @IBOutlet weak var deal3: UIButton!
    
    @IBAction func deal3cards(_ sender: Any) {
        
        if renderedCards == 21{                 //hide and disable deal 3 more cards button
            deal3.isUserInteractionEnabled = false
            deal3.isHidden = true
            set.deal3Cards()
            loadViewUI()
            return
        }
        
        deal3.isUserInteractionEnabled = true
        deal3.isHidden = false
        set.deal3Cards()
        loadViewUI()
    }
    
    func checkMatch() {
        if currentSet.count < 3 {       //incomplete set
            return
        }
        
        if set.checkEquatable() {
            resetSet()
            loadViewUI()
        }
    }
    
    func loadViewUI() {
        
        renderedCards = 0
        
        for i in 0..<cardButtons.count {
            if set.returnCard_i(index: i) != nil {
                var cardColor: UIColor
                var cardFace: String = ""
                var stroke: UIColor
                var mergeSttributes: [NSAttributedString.Key: Any]
                var strokeValue: Int
                
                for _ in 0..<set.returnCard_i(index: i)!.number.rawValue {
                    cardFace.append(set.returnCard_i(index: i)!.shape.rawValue)
                }
                
                if cardFace.count == 2 {        //resize to fit card
                    cardButtons[i].titleLabel?.font = cardButtons[i].titleLabel?.font.withSize(40)
                }
                
                if cardFace.count == 3 {        //resize to fit card
                    cardButtons[i].titleLabel?.font = cardButtons[i].titleLabel?.font.withSize(29)
                }
                
                //color gradient
                if set.returnCard_i(index: i)!.color == Color.gold {
                    cardColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                } else if set.returnCard_i(index: i)!.color == Color.pink {
                    cardColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                } else {
                    cardColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                }
                
                stroke = cardColor
                
                //shading gradient
                if set.returnCard_i(index: i)!.shading == Shading.open {
                    strokeValue = 5
                    cardColor = cardColor.withAlphaComponent(0)
                } else if set.returnCard_i(index: i)!.shading == Shading.shaded {
                    strokeValue = -5
                    cardColor = cardColor.withAlphaComponent(0.35)
                } else {
                    strokeValue = 0
                    cardColor = cardColor.withAlphaComponent(1)
                }
                
                mergeSttributes = [NSAttributedString.Key.strokeWidth : strokeValue, NSAttributedString.Key.foregroundColor : cardColor, NSAttributedString.Key.strokeColor: stroke]
                let finalAttributes = NSAttributedString(string: cardFace, attributes: mergeSttributes)
                
                cardButtons[i].backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                cardButtons[i].setAttributedTitle(finalAttributes, for: UIControl.State.normal)
                renderedCards += 1
                
            } else {
                cardButtons[i].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                cardButtons[i].setAttributedTitle(nil, for: UIControl.State.normal)
                cardButtons[i].setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    func resetSet() {
        for i in 0..<currentSet.count {
            cardButtons[currentSet[i]].layer.borderWidth = 0.0
            cardButtons[currentSet[i]].layer.borderColor = UIColor.clear.cgColor
            cardButtons[currentSet[i]].layer.cornerRadius = 0.0
        }
        currentSet.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewUI()
    }
    
    override func didReceiveMemoryWarning() {       //handle for accessing memory beyond assigned scope
        super.didReceiveMemoryWarning()
    }
}
