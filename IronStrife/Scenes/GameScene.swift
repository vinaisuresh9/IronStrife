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


enum WorldLayer: CGFloat {
    case Background = 0.1,
    Other = 0.2,
    Shadow = 0.3,
    Projectile = 0.4,
    Character = 0.5
    
}

class GameScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate{

    var lastUpdateTimeInterval: NSTimeInterval = 0
    let player = Player.sharedInstance
    var currentMovementAnimationKey = ""
    
    var upScene: GameScene?
    var downScene: GameScene?
    var rightScene: GameScene?
    var leftScene: GameScene?
    
    func setupScene()
    {
        //Do some initial setup
        self.initializeGestureRecognizers()
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "Background.png")
        background.size = self.frame.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.addChild(background)
    }
    
    //Overridden
    func createEdges() {
        
    }
    
    func initializeGestureRecognizers(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        tapGesture.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapGesture)
        
        let twoFingerTapGesture = UITapGestureRecognizer(target: self, action: "twoFingerTap:")
        twoFingerTapGesture.numberOfTouchesRequired = 2
        self.view?.addGestureRecognizer(twoFingerTapGesture)
        
        let twoFingerLongPressGesture = UILongPressGestureRecognizer(target: self, action: "twoFingerLongPress:")
        twoFingerLongPressGesture.numberOfTouchesRequired = 2
        twoFingerLongPressGesture.minimumPressDuration = 0.1
        twoFingerLongPressGesture.allowableMovement = 5
        self.view?.addGestureRecognizer(twoFingerLongPressGesture)
        
        let movementGesture = UILongPressGestureRecognizer(target: self, action: "longPress:")
        movementGesture.minimumPressDuration = 0.3
        self.view?.addGestureRecognizer(movementGesture)
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        upSwipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(upSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view?.addGestureRecognizer(rightSwipeGesture)
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        downSwipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(downSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.view?.addGestureRecognizer(leftSwipeGesture)
        

        self.view?.showsPhysics = true
        
        
    }
    
    
    func swiped (sender: UISwipeGestureRecognizer){
        player.attackInDirection(sender.direction)
    }
    
    
    func tapped (sender: UITapGestureRecognizer){
        let point = sender.locationInView(self.view)
        player.castFireball(self.view!.convertPoint(point, toScene: self))
    }
    
    
    func twoFingerTap (sender: UITapGestureRecognizer) {
        player.castIceSpell()
    }
    
    
    func twoFingerLongPress (sender: UILongPressGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.Began) {
            self.player.castCureSpell()
        }
    }
    
    
    func longPress (sender: UILongPressGestureRecognizer){
        let point = sender.locationInView(self.view)
        let scenePoint = self.view!.convertPoint(point, toScene: self)
        player.moveTo(scenePoint)
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        //Can use contactNormal vector to decided pushback vector for gettingHit animation
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
    func transitionUp (newScene: GameScene) {
        
    }
    
    func transitionRight (newScene:GameScene) {
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.1)
        self.view?.presentScene(newScene, transition: transition)

    }
    
    func transitionLeft (newScene:GameScene) {
    }
    
    func transitionDown(newScene:GameScene) {
        
    }
    

    
    //MARK: Update Loop
    override func update(currentTime: NSTimeInterval) {
        let timeSinceLast = currentTime - self.lastUpdateTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
        self.updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    //Overridden
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        for node in self.children {
            if (node is Character) {
                node.updateWithTimeSinceLastUpdate(timeSince)
            }
        }
    }

}

