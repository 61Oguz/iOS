//
//  ViewController.swift
//  CacthTheCartmanTheGame
//
//  Created by Oguzhan Aydin

import UIKit

class ViewController: UIViewController {
    
    //Labels
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLAbel: UILabel!
    
    //Variables
    var score = 0;
    var highScore = 0 ;
    var timer = Timer();
    var hideTimer = Timer() ;
    var time = 30 ;
    var array :[UIImageView] = []
    
    //Images
    @IBOutlet weak var cartman1: UIImageView!
    @IBOutlet weak var cartman2: UIImageView!
    @IBOutlet weak var cartman3: UIImageView!
    @IBOutlet weak var cartman4: UIImageView!
    @IBOutlet weak var cartman5: UIImageView!
    @IBOutlet weak var cartman6: UIImageView!
    @IBOutlet weak var cartman7: UIImageView!
    @IBOutlet weak var cartman8: UIImageView!
    @IBOutlet weak var cartman9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Starting Time
        remainingTimeLabel.text = "\(time)";
        
        //Timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (timeCount), userInfo: nil, repeats: true)
        
        //hideTimer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector (hideCartman), userInfo: nil, repeats: true);
        
        //Current Score
        currentScoreLabel.text = "Score: \(score)"
        
        //High Score
        let storedScore = UserDefaults.standard.object(forKey: "highScore") ;
        
        if storedScore == nil {
            highScore = 0;
            highScoreLAbel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedScore as? Int {
            highScore = newScore
            highScoreLAbel.text = "HighScore: \(highScore)"
        }
        //Interaction is enabled when clicked
        cartman1.isUserInteractionEnabled = true ;
        cartman2.isUserInteractionEnabled = true ;
        cartman3.isUserInteractionEnabled = true ;
        cartman4.isUserInteractionEnabled = true ;
        cartman5.isUserInteractionEnabled = true ;
        cartman6.isUserInteractionEnabled = true ;
        cartman7.isUserInteractionEnabled = true ;
        cartman8.isUserInteractionEnabled = true ;
        cartman9.isUserInteractionEnabled = true ;
        
        array = [cartman1,cartman2,cartman3,cartman4,cartman5,cartman6,cartman7,cartman8,cartman9]
        
        let recog1 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog2 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog3 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog4 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog5 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog6 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog7 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog8 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
        let recog9 = UITapGestureRecognizer(target: self, action: #selector (addScore) )
      
        cartman1.addGestureRecognizer(recog1);
        cartman2.addGestureRecognizer(recog2);
        cartman3.addGestureRecognizer(recog3);
        cartman4.addGestureRecognizer(recog4);
        cartman5.addGestureRecognizer(recog5);
        cartman6.addGestureRecognizer(recog6);
        cartman7.addGestureRecognizer(recog7);
        cartman8.addGestureRecognizer(recog8);
        cartman9.addGestureRecognizer(recog9);
      
        hideCartman();
    }
    //Increasing the Score
    @objc func addScore(){
        score += 1 ;
        currentScoreLabel.text = "Score: \(score)"
        
    }
    
    //Hiding Function
    
    @objc func hideCartman() {
        
        for i in array {
            i.isHidden = true ;
        }
        let random = Int ( arc4random_uniform(UInt32(array.capacity)))
        array[random].isHidden = false
    }
    
    //Counting the Time
    @objc func timeCount(){
        remainingTimeLabel.text = "\(time)" ;
        time -= 1 ;
        
        if( time == -1 ){
            hideTimer.invalidate();
            timer.invalidate();
            
            if (self.highScore < self.score) {
                self.highScore = self.score
                self.highScoreLAbel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highScore")
            }
            //Buttons and Alerts
            let alert = UIAlertController(title: "Time's Up! ", message: "Score: \(score) \n Do you want to play again ? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            let playAgainButton = UIAlertAction(title: "Play Again!", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.score = 0;
                self.time = 5 ; 
                self.remainingTimeLabel.text = "\(self.time)"
                //Timer
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.timeCount), userInfo: nil, repeats: true)
                //hideTimer
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector (self.hideCartman), userInfo: nil, repeats: true);
            }
            alert.addAction(okButton);
            alert.addAction(playAgainButton);
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }


}

