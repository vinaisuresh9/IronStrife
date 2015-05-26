//
//  Room1Scene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 5/25/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Room1Scene: GameScene {
   
    
    override func didMoveToView(view: SKView) {
        super.setupScene()
        
        /* Setup your scene here */
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(player)
        
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
    
}
