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
        player.removeFromParent()
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(player)
        
        let firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 10, y: CGRectGetMidY(self.frame))
        self.addChild(firstEnemy)
        
        self.leftScene = Room1Scene.unarchiveFromFile("Room1Scene") as? Room1Scene
        self.leftScene?.scaleMode = SKSceneScaleMode.AspectFill
                
    }
    
    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        
        self.leftScene = nil
        self.rightScene = nil
        self.upScene = nil
        self.downScene = nil
    }
    
    override func createEdges() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(10, 10, self.frame.width-20, self.frame.height-20))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = CollisionBitMask.Wall.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Player.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Player.rawValue
    }
    
    override func didBeginContact(contact: SKPhysicsContact) {
        super.didBeginContact(contact)
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if ((nodeA is Player || nodeB is Player) && (nodeA is TownScene || nodeB is TownScene)) {
            if let leftScene = self.leftScene  {
                let contactPoint = contact.contactPoint
                let screenWidth = UIScreen.mainScreen().bounds.width
                leftScene.startPoint = CGPointMake(screenWidth - contactPoint.x, contactPoint.y)
                self.transitionLeft(leftScene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
    }
    
}
