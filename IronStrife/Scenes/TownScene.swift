//
//  TownScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class TownScene: GameScene {


    
    override func didMoveToView(view: SKView) {
        self.initializeGestureRecognizers()
        
        self.backgroundColor = UIColor.whiteColor()
        /* Setup your scene here */
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        player.setScale(0.8)
        self.addChild(player)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
