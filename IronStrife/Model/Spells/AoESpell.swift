//
//  AoESpell.swift
//  IronStrife
//
//  Created by Vinai Suresh on 2/20/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class AoESpell: SKSpriteNode {
    var owner: Player?
    var textures: [SKTexture] = []
    
    func configurePhysicsBody(){
        self.setScale(0.8)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width/2)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = CollisionBitMask.Spell.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Enemy.rawValue
        self.physicsBody?.dynamic = false
    }
    
}