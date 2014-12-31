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
    case Player = 1,
    Projectile = 2,
    Enemy = 4,
    Other = 8
    
}

class GameScene: SKScene, UIGestureRecognizerDelegate{

    let player = Player.sharedInstance
    var currentMovementAnimationKey = ""
    
    func initializeGestureRecognizers(){
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        tapGesture.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapGesture)
        
        var twoFingerTapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        twoFingerTapGesture.numberOfTouchesRequired = 2
        self.view?.addGestureRecognizer(twoFingerTapGesture)
        
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
        self.player.removeAllActions()
        let point = sender.locationInView(self.view)
        player.castFireball(self.view!.convertPoint(point, toScene: self))
        
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
//        player.physicsBody?.velocity = CGVectorMake(velocity.dx * player.movespeed, velocity.dy * player.movespeed)
        var movementAction = SKAction.moveTo(scenePoint, duration: time)
        player.runAction(movementAction)
        
    }
    
    
    func checkDestination(){
        if (self.player.reachedDestination()){
            self.player.removeActionForKey(currentMovementAnimationKey)
            self.player.stopMoving()
        }
        
    }
    
    
    override func update(currentTime: NSTimeInterval) {

    }

}

