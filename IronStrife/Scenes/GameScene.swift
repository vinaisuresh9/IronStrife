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


enum WorldLayer: UInt32 {
    case Background = 1,
    Other,
    Projectile,
    Character
    
}

class GameScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate{

    var lastUpdateTimeInterval: NSTimeInterval = 0
    let player = Player.sharedInstance
    var currentMovementAnimationKey = ""
    
    func initializeGestureRecognizers(){
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        tapGesture.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapGesture)
        
        var twoFingerTapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        twoFingerTapGesture.numberOfTouchesRequired = 2
        self.view?.addGestureRecognizer(twoFingerTapGesture)
        
        var twoFingerLongPressGesture = UILongPressGestureRecognizer(target: self, action: "twoFingerLongPress:")
        twoFingerLongPressGesture.numberOfTouchesRequired = 2
        self.view?.addGestureRecognizer(twoFingerLongPressGesture)
        
        var movementGesture = UILongPressGestureRecognizer(target: self, action: "longPress:")
        movementGesture.minimumPressDuration = 0.3
        self.view?.addGestureRecognizer(movementGesture)
        
        var upSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        upSwipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view?.addGestureRecognizer(upSwipeGesture)
        
        var rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.view?.addGestureRecognizer(rightSwipeGesture)
        
        var downSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        downSwipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view?.addGestureRecognizer(downSwipeGesture)
        
        var leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: "swiped:")
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.view?.addGestureRecognizer(leftSwipeGesture)

        self.view?.showsPhysics = true
        
        
    }
    
    func swiped (sender: UISwipeGestureRecognizer){
        player.attackInDirection(sender.direction)
    }
    
    
    func tapped (sender: UITapGestureRecognizer){
        if (sender.numberOfTapsRequired == 1){
            let point = sender.locationInView(self.view)
            player.castFireball(self.view!.convertPoint(point, toScene: self))
            return
        }
        else if (sender.numberOfTouchesRequired == 2){
            player.castIceSpell()
            return
        }

        
    }
    
    func twoFingerLongPress (sender: UILongPressGestureRecognizer){
        self.player.castCureSpell()
    }
    
    func longPress (sender: UILongPressGestureRecognizer){
        let point = sender.locationInView(self.view)
        let scenePoint = self.view!.convertPoint(point, toScene: self)
        let distance = MathFunctions.calculateDistance(self.player.position, point2: scenePoint)
        let time = distance/Double(player.movespeed)
        var velocity = MathFunctions.normalizedVector(self.player.position, point2: scenePoint)
        
        player.destination = scenePoint
        
        player.setDirection(scenePoint, moving: true)
        currentMovementAnimationKey = self.player.direction
        player.physicsBody?.velocity = CGVectorMake(velocity.dx * player.movespeed, velocity.dy * player.movespeed)
        //var movementAction = SKAction.moveTo(scenePoint, duration: time)
        //player.runAction(movementAction, withKey: player.direction)
        
    }
    
    func checkDestination(){
        if (self.player.reachedDestination()){
            self.player.stopMoving()
            self.player.removeAllActions()
        }
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("Contact")
        //Can use contactNormal vector to decided pushback vector for gettingHit animation
        let nodeA = contact.bodyA.node
        if (nodeA is Character){
            let body = nodeA as Character
            body.collidedWith(contact.bodyB)
        }
        
        let nodeB = contact.bodyA.node
        if (nodeA is Character){
            let body = nodeB as Character
            body.collidedWith(contact.bodyA)
        }
        
        //TODO: Need to handle projectile collisions with non-characters
    }

    
    //MARK: Update Loop
    override func update(currentTime: NSTimeInterval) {
        let timeSinceLast = currentTime - self.lastUpdateTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
        self.updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    //Overridden
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        self.player.updateWithTimeSinceLastUpdate(timeSince)
    }

}

