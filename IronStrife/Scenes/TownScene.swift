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
        //Do some initial setup
        self.initializeGestureRecognizers()
        self.physicsWorld.gravity = CGVector.zeroVector
        self.physicsWorld.contactDelegate = self
        
        
        let background = SKSpriteNode(imageNamed: "Background.png")
        background.size = self.frame.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.addChild(background)
        
        /* Setup your scene here */
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(player)
        
        var firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 10, y: CGRectGetMidY(self.frame))
        self.addChild(firstEnemy)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        if (self.player.actionForKey(currentMovementAnimationKey) != nil){
            checkDestination()
        }
    }
    
//    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval) {
//        //Update physics bodies for all ice spells
//
//    }
    
}
