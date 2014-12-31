//
//  Character.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/26/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit


enum CollisionBitMask: UInt32 {
    case Player = 1,
    Projectile = 2,
    Enemy = 4,
    Other = 8
    
}

enum AttackDirection {
    case Left,
    Right,
    Down,
    Up
}

class Character: SKSpriteNode {
    var health: Float = 0.0
    var mana: Float = 0.0
    
    var attackStrength: Float = 0.0
    var defense: Float = 0.0
    
    var isDying: Bool = false
    var isAttacking: Bool = false
    var isHit: Bool = false
    
    let animationMovementSpeed = 0.1
    let animationAttackSpeed = 0.05
    
    var movespeed: CGFloat = 250
    
    var destination: CGPoint = CGPointMake(0, 0)

    
    //MARK: Texture Arrays
    var downMovementTextures: [SKTexture] = []
     var upMovementTextures: [SKTexture] = []
     var leftMovementTextures: [SKTexture] = []
     var rightMovementTextures: [SKTexture] = []
     var upAttackTextures: [SKTexture] = []
     var downAttackTextures: [SKTexture] = []
     var leftAttackTextures: [SKTexture] = []
     var rightAttackTextures: [SKTexture] = []
    var getHitAnimationFrames: [SKTexture] = []
    var deathAnimationFrames: [SKTexture] = []
    
    
    //MARK: Physics Bodies (Overridden)
    func configurePhysicsBody(){
        
    }
    
    func collidedWith (other: SKPhysicsBody){
        
    }
    
    //MARK: Applying Damage
    //TODO: Figure out pushback animations and how damage is applied
    func applyDamage(damage: CGFloat) -> Bool{
        
        return false
    }
    
    func applyDamageFromProjectile(damage: CGFloat, projectile: Projectile) -> Bool {
        return false
    }
    
    //MARK: Attacking 
    func meleeAttack(direction: AttackDirection){
        if (self.isAttacking){
            return
        }
        self.stopMoving()
        self.isAttacking = true
        
        var attackAnimation: SKAction
        switch (direction){
            
        case AttackDirection.Up:
            attackAnimation = SKAction.animateWithTextures(upAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Down:
            
            attackAnimation = SKAction.animateWithTextures(downAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Right:
            attackAnimation = SKAction.animateWithTextures(rightAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Left:
            attackAnimation = SKAction.animateWithTextures(leftAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        default:
            break
            
        }
        
        self.runAction(attackAnimation, completion:{
                self.isAttacking = false
            })

        
        
    }
    
    func stopMoving(){
        self.physicsBody?.velocity = CGVector.zeroVector
        self.destination = self.position
        
    }
    
    func initializeTextureArrays(){
        
    }
    

}
