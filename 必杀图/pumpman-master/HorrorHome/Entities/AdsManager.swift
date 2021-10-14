//
//  AdsManager.swift
//  HorrorHome
//
//  Created by Italo Henrique Queiroz on 19/10/17.
//  Copyright © 2017 Italo Henrique Queiroz. All rights reserved.
//

import UnityAds

class AdsManager {
    
    var completion: (() -> Void)?
    static var shared: AdsManager = AdsManager()
    var viewController: UIViewController?
    
    func showAdsWithCompletion(controller: UIViewController? = nil, id: String, completion: (() -> Void)?){
        var vController: UIViewController!
        if controller == nil && viewController != nil{
            vController = viewController
        }else if controller != nil {
            vController = controller
        } else {
            return
        }
        if UnityAds.isReady(id) {
            UnityAds.show(vController, placementId: id)
            self.completion = completion
        }else {
            completion?()
        }
    }
    
    private init(){}
}



