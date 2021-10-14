//
//  SoundController.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 19/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import SpriteKit
import AVFoundation

class SoundController: NSObject {
    
    static let shared: SoundController = SoundController()
    
    var jumpAction:AVAudioPlayer!
    var musicAction: AVAudioPlayer!
    var cheeseSound: AVAudioPlayer!
    var dead: AVAudioPlayer!
    var powerUp: AVAudioPlayer!
    override private init(){}
    
    func loadAudios(){
        
        self.musicAction = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Action", ofType: "mp3")!))
        self.jumpAction = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "jump", ofType: "wav")!))
        self.cheeseSound = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "cheeseSound", ofType: "m4a")!))
        
         self.dead = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "dead", ofType: "wav")!))
        self.powerUp = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Powerup", ofType: "wav")!))
        self.cheeseSound.volume = 1
        self.musicAction.delegate = self
        self.musicAction.numberOfLoops = -1
        self.jumpAction.volume = 0.3
    }

    func playMusic(){
        self.musicAction.play()
    }
    
    func pauseMusic(){
        self.musicAction.pause()
    }
    
    func playPowerUp(){
        self.powerUp.play()
    }
    func playDead(){
        self.dead.play()
    }
    
    func playCheese(){
        self.cheeseSound.currentTime = 0
        self.cheeseSound.play()
    }
    
    func playJump(){
        self.jumpAction.play()
    }

}



extension SoundController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.play(atTime: 0)
    }
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        player.pause()
    }
    
    func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        player.play()
    }
    
}
