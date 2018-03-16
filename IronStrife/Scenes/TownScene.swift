//
//  TownScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class TownScene: GameScene, SceneTransitioning {

    // MARK: - SceneTransitioning
    var leftScene: GameScene? = Room1Scene.unarchiveFromFile("Room1Scene") as? Room1Scene
    var rightScene: GameScene?
    var upScene: GameScene?
    var downScene: GameScene?

    override func didMove(to view: SKView) {
        super.setupScene()
    
        /* Setup your scene here */
        player.removeFromParent()
        player.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(player)
        
        let firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 40, y: self.frame.midY)
        self.addChild(firstEnemy)
        
        self.leftScene = Room1Scene.unarchiveFromFile("Room1Scene") as? Room1Scene
        self.leftScene?.scaleMode = SKSceneScaleMode.aspectFill
                
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        
        self.leftScene = nil
        self.rightScene = nil
        self.upScene = nil
        self.downScene = nil
    }
    
    override func createEdges() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 10, y: 10, width: self.frame.width-20, height: self.frame.height-20))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CollisionBitMask.wall.rawValue
        self.physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.player.rawValue
        
    }
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if ((nodeA is Player || nodeB is Player) && (nodeA is TownScene || nodeB is TownScene)) {
            if let leftScene = self.leftScene  {
                let contactPoint = contact.contactPoint
                let screenWidth = UIScreen.main.bounds.width
                leftScene.startPoint = CGPoint(x: screenWidth - contactPoint.x, y: contactPoint.y)
                PlayerOverviewManager.sharedInstance.currentScene = leftScene
                self.transitionLeft(leftScene)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
