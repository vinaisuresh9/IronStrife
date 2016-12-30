//
//  GameScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/18/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//


//TODO: Will need to preload each level's textures into memory
//TODO: Might need to use a plist file for texture settings if needed later (and constant strings like downMovementAnimation).

import SpriteKit
import UIKit


struct WorldLayer {
    static let background: CGFloat = -1
    static let other: CGFloat = 0.2
    static let shadow: CGFloat = 0.3
    static let projectile: CGFloat = 0.4
    static let character: CGFloat = 0.5
}

class GameScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate{

    var lastUpdateTimeInterval: TimeInterval = 0
    let player = Player.sharedInstance
    var currentMovementAnimationKey = ""
    var startPoint:CGPoint = CGPoint.zero
    
    var upScene: GameScene?
    var downScene: GameScene?
    var rightScene: GameScene?
    var leftScene: GameScene?
    
    let transitionTime: TimeInterval = 1
    
    func setupScene()
    {
        //Do some initial setup
        self.initializeGestureRecognizers()
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
        self.createEdges()
        
        
        let background = SKSpriteNode(imageNamed: "Background.png")
        background.size = self.frame.size
        background.zPosition = WorldLayer.background
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        self.addChild(background)
    }
    
    //Overridden
    func createEdges() {
        
    }
    
    func initializeGestureRecognizers(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameScene.tapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapGesture)
        
        let twoFingerTapGesture = UITapGestureRecognizer(target: self, action: #selector(GameScene.twoFingerTap(_:)))
        twoFingerTapGesture.numberOfTouchesRequired = 2
        self.view?.addGestureRecognizer(twoFingerTapGesture)
        
        let twoFingerLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.twoFingerLongPress(_:)))
        twoFingerLongPressGesture.numberOfTouchesRequired = 2
        twoFingerLongPressGesture.minimumPressDuration = 0.1
        twoFingerLongPressGesture.allowableMovement = 5
        self.view?.addGestureRecognizer(twoFingerLongPressGesture)
        
        let movementGesture = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.longPress(_:)))
        movementGesture.minimumPressDuration = 0.3
        self.view?.addGestureRecognizer(movementGesture)
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
        upSwipeGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(upSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(rightSwipeGesture)
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
        downSwipeGesture.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(downSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(leftSwipeGesture)
        

        self.view?.showsPhysics = true
        
        
    }
    
    func swiped (_ sender: UISwipeGestureRecognizer){
        player.attackInDirection(sender.direction)
    }
    
    
    func tapped (_ sender: UITapGestureRecognizer){
        let point = sender.location(in: self.view)
        player.castFireball(self.view!.convert(point, to: self))
    }
    
    
    func twoFingerTap (_ sender: UITapGestureRecognizer) {
        player.castIceSpell()
    }
    
    
    func twoFingerLongPress (_ sender: UILongPressGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.began) {
            self.player.castCureSpell()
        }
    }
    
    
    func longPress (_ sender: UILongPressGestureRecognizer){
        let point = sender.location(in: self.view)
        if let view = self.view {
            let scenePoint = view.convert(point, to: self)
            player.moveTo(position: scenePoint)
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //TODO: Can use contactNormal vector to decided pushback vector for gettingHit animation
        let nodeA = contact.bodyA.node
        if (nodeA is Character){
            let body = nodeA as! Character
            body.collidedWith(contact.bodyB)
            return
        }
        
        let nodeB = contact.bodyB.node
        if (nodeB is Character){
            let body = nodeB as! Character
            body.collidedWith(contact.bodyA)
            return
        }
        
        //TODO: Need to handle projectile collisions with non-characters
        if (contact.bodyA.node is Fireball) {
            let fireball = contact.bodyA.node as! Fireball
            fireball.explode()
            return
        }
        
        if (contact.bodyB.node is Fireball) {
            let fireball = contact.bodyB.node as! Fireball
            fireball.explode()
            return
        }
    }
    
    
    //MARK: Transitioning Scenes
    func transitionUp (_ newScene: GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.down, duration: transitionTime)
        self.view?.presentScene(newScene, transition: transition)
    }
    
    func transitionRight (_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.left, duration: transitionTime)
        self.view?.presentScene(newScene, transition: transition)

    }
    
    func transitionLeft (_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.right, duration: transitionTime)
        self.view?.presentScene(newScene, transition: transition)
    }
    
    func transitionDown(_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.up, duration: transitionTime)
        self.view?.presentScene(newScene, transition: transition)
    }
    

    
    //MARK: Update Loop
    override func update(_ currentTime: TimeInterval) {
        let timeSinceLast = currentTime - self.lastUpdateTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
        self.updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    //Overridden
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){
        for node in self.children {
            if (node is Character) {
                node.updateWithTimeSinceLastUpdate(timeSince)
            }
        }
    }

}

