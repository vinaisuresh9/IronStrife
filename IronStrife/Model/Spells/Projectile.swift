//
//  Projectile.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//


import SpriteKit

class Projectile: SKSpriteNode {
    var owner: Character?
    
    override func configurePhysicsBody(){
        self.setScale(0.8)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        if (owner is Player){
            self.physicsBody?.categoryBitMask = CollisionBitMask.PlayerProjectile.rawValue
            self.physicsBody?.collisionBitMask = CollisionBitMask.Enemy.rawValue | CollisionBitMask.Other.rawValue | CollisionBitMask.EnemyProjectile.rawValue
            self.physicsBody!.contactTestBitMask = self.physicsBody!.collisionBitMask
        }
        if (owner is Enemy){
            self.physicsBody?.categoryBitMask = CollisionBitMask.EnemyProjectile.rawValue
            self.physicsBody?.collisionBitMask = CollisionBitMask.Enemy.rawValue | CollisionBitMask.Other.rawValue | CollisionBitMask.Player.rawValue | CollisionBitMask.PlayerProjectile.rawValue
            self.physicsBody!.contactTestBitMask = self.physicsBody!.collisionBitMask
        }
    }
    
}
