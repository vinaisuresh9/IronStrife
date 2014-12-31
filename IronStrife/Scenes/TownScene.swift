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
        
        let background = SKSpriteNode(imageNamed: "Background.png")
        background.size = self.frame.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.addChild(background)
        
        /* Setup your scene here */
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        player.setScale(0.8)
        self.addChild(player)
        
        var firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 10, y: CGRectGetMidY(self.frame))
        firstEnemy.setScale(0.8)
        self.addChild(firstEnemy)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        if (self.player.actionForKey(currentMovementAnimationKey) != nil){
            checkDestination()
        }
    }
    
}
