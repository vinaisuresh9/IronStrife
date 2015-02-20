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
        super.setupScene()
    
        /* Setup your scene here */
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(player)
        
        var firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 10, y: CGRectGetMidY(self.frame))
        self.addChild(firstEnemy)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
//    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval) {
//        //Update physics bodies for all ice spells
//
//    }
    
}
