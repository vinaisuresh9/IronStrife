//
//  GameScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/18/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene, UIGestureRecognizerDelegate{
    
    let player = Player.sharedInstance
    var fireVectorStart = CGPointMake(0, 0)
    
    func initializeGestureRecognizers(){
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        var movementGesture = UILongPressGestureRecognizer(target: self, action: "longPress:")
        movementGesture.minimumPressDuration = 0.3
        self.view.addGestureRecognizer(movementGesture)
        
        self.view.showsPhysics = true
        
        
    }
    
    func tapped (sender: UITapGestureRecognizer){
        let point = sender.locationInView(self.view)
        let (fireball, moves) = Player.sharedInstance.castFireball(self.view.convertPoint(point, toScene: self))
        self.addChild(fireball)
        fireball!.runAction(SKAction.sequence(moves))
    }
    
    func longPress (sender: UILongPressGestureRecognizer){
        let point = sender.locationInView(self.view)
        let scenePoint = self.view.convertPoint(point, toScene: self)
        let distance = MathFunctions.calculateDistance(self.player.position, point2: scenePoint)
        let moveAction = SKAction.moveTo(scenePoint, duration: (distance/self.player.movespeed))
        self.player.runAction(moveAction)
    }
    
    
    
    override func update(currentTime: NSTimeInterval) {
        
    }

}

