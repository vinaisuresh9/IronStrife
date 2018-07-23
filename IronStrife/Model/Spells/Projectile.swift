//
//  Projectile.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//


import SpriteKit

class Projectile: SKSpriteNode, PhysicsBodyContaining {
    var owner: Character?
    
    func configurePhysicsBody(){
        setScale(0.8)
        physicsBody = SKPhysicsBody(rectangleOf: frame.size)
        physicsBody?.allowsRotation = false
        physicsBody?.mass = 0
        physicsBody?.restitution = 0
        physicsBody?.angularDamping = 0
        physicsBody?.linearDamping = 0
        physicsBody?.friction = 0
        zPosition = WorldLayer.projectile
        if (owner is Player){
            physicsBody?.categoryBitMask = CollisionBitMask.playerProjectile.rawValue
            physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue | CollisionBitMask.other.rawValue | CollisionBitMask.enemyProjectile.rawValue
            physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        }
        if (owner is Enemy){
            physicsBody?.categoryBitMask = CollisionBitMask.enemyProjectile.rawValue
            physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue | CollisionBitMask.other.rawValue | CollisionBitMask.player.rawValue | CollisionBitMask.playerProjectile.rawValue
            physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        }
    }
    
}
