//
//  GameScore.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 18/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import Foundation


protocol NotificationDelegate {
    func scoreChanged(score: Int)
}
class GameScore {
    
    private var score: Int = 0 {
        didSet {
            for i in notificationDelegates {
                i.scoreChanged(score: self.score)
            }
        }
    }
    static let shared: GameScore = GameScore()
    
    var notificationDelegates = [NotificationDelegate]()
    var newHighCompletion: ((Int) -> Void)?
    func saveIfHigher(){
        if let higher = self.getHigher() {
            if score > higher {
                UserDefaults.standard.set(self.score, forKey: "Score")
                self.newHighCompletion?(self.score)
            }
        }else {
            UserDefaults.standard.set(self.score, forKey: "Score")
        }
        self.score = 0
    }
    func getScore() -> Int{
        return score
    }
    
    func incrementScore(){
        score += 1
    }
    
    func decrementScore(){
        score -= 1
    }
    
    func getHigher() -> Int?{
        return UserDefaults.standard.object(forKey: "Score") as? Int
    }
    
    
    private init(){}
}
