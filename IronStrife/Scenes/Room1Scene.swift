//
//  Room1Scene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 5/25/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Room1Scene: GameScene {
   
    
    override func didMove(to view: SKView) {
        super.setupScene()
        
        /* Setup your scene here */
        player.removeFromParent()
        player.position = self.startPoint
        self.addChild(player)
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    
}
