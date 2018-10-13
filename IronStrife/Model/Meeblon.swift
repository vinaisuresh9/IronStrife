//
//  Meeblon.swift
//  IronStrife
//
//  Created by Vinai Suresh on 1/4/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Meeblon: Enemy {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureStats()
        initializeTextureArrays()
        initializeShadowAndPosition()

        NotificationCenter.default.addObserver(self, selector: #selector(configurePhysicsBody), name: .physicsWorldCreated, object: nil)
    }
    
    override func configureStats() {
        health = 100
        type = AttackType.range
        attackStrength = 15
        defense = 5
        colorBlendFactor = 0.5
    }
    
    //MARK: PhysicsBody and Delegate
    @objc private func configurePhysicsBody() {
        super.configureDefaultPhysicsBody()
        physicsBody!.collisionBitMask = CollisionBitMask.enemy.rawValue | CollisionBitMask.other.rawValue | CollisionBitMask.player.rawValue | CollisionBitMask.playerProjectile.rawValue
        physicsBody?.contactTestBitMask = CollisionBitMask.playerProjectile.rawValue | CollisionBitMask.player.rawValue | CollisionBitMask.enemyProjectile.rawValue
        physicsBody!.categoryBitMask = CollisionBitMask.enemy.rawValue
        
    }
    
    //TODO: Check collision with Player Sword
    override func collidedWith(_ other: SKPhysicsBody) {
        if (self.isDying){
            return
        }
        let otherNode = other.node
        if (otherNode is Fireball){
            let killed = self.applyDamage(Fireball.attackDamage)
            otherNode?.removeFromParent()
            if (killed){
                //TODO: Add score and EXP to player
                self.removeFromParent()
            }
        }
        
    }
    
    //MARK: Death
    override func performDeath() {
        super.performDeath()
        
        //TODO: Death Animation
        
    }
    
    //MARK: Setup
    override func initializeTextureArrays(){
        let atlas = Textures.meeblonTextures
        
        for i in 2..<5 {
            downMovementTextures.append(atlas.textureNamed("Down\(i)"))
            rightMovementTextures.append(atlas.textureNamed("Right\(i)"))
            leftMovementTextures.append(atlas.textureNamed("Left\(i)"))
            upMovementTextures.append(atlas.textureNamed("Up\(i)"))
        }

        
    }
}
