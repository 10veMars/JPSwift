//
//  GameViewController.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 06/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import UnityAds

class GameViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentScene()
        UnityAds.initialize("1579660", delegate: self)
        AdsManager.shared.viewController = self
    }
    
    func presentScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
        
            // Present the scene
            view.presentScene(scene)
            
           //view.showsPhysics = true
            view.ignoresSiblingOrder = true
           // view.showsFPS = true
         //   view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension GameViewController: UnityAdsDelegate {
    
    func unityAdsReady(_ placementId: String) {
    
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        
    }
    
    func unityAdsDidStart(_ placementId: String) {
        SoundController.shared.pauseMusic()
    }
    
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        AdsManager.shared.completion?()
        SoundController.shared.playMusic()
    }
    
}

