//
//  AoESpell.swift
//  IronStrife
//
//  Created by Vinai Suresh on 2/20/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class AoESpell: SKSpriteNode, PhysicsBodyContaining {
    var owner: Player?
    var textures: [SKTexture] = []
    
    func configurePhysicsBody(){
        setScale(0.8)
        physicsBody = SKPhysicsBody(circleOfRadius: frame.width/2)
        physicsBody?.allowsRotation = false
        physicsBody?.mass = 0
        physicsBody?.restitution = 0
        physicsBody?.angularDamping = 0
        physicsBody?.linearDamping = 0
        physicsBody?.friction = 0
        physicsBody?.categoryBitMask = CollisionBitMask.spell.rawValue
        physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue
        physicsBody?.contactTestBitMask = CollisionBitMask.enemy.rawValue
        physicsBody?.isDynamic = false
        zPosition = WorldLayer.projectile
    }
    
}
