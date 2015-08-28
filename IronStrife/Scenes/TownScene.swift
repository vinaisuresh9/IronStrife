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
        
        self.leftScene = Room1Scene.unarchiveFromFile("Room1Scene") as? Room1Scene
        self.leftScene?.scaleMode = SKSceneScaleMode.AspectFill
        
    }
    
    override func createEdges() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(10, 10, self.frame.width-20, self.frame.height-20))
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Player.rawValue
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        super.didBeginContact(contact)
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
}
