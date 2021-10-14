//
//  LaunchScreenViewController.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 19/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import UIKit


class LaunchScreenViewController: UIViewController {
    

    override func viewDidLoad() {
        SoundController.shared.loadAudios()
        SpritesManager.shared.carregarSprites()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: {_ in
            self.show(UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") , sender: nil)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
}
