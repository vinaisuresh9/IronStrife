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
    PlayerProjectile = 2,
    EnemyProjectile = 4,
    Enemy = 8,
    Other = 16,
    Spell = 32
    
}

enum AttackDirection {
    case Left,
    Right,
    Down,
    Up
}


///Base class for all Characters in game. Many methods need to be overridden
class Character: SKSpriteNode {
    var health: Float = 0.0
    var mana: Float = 0.0
    
    var attackStrength: Float = 0.0
    var defense: Float = 0.0
    
    var isDying: Bool = false
    var isAttacking: Bool = false
    var isHit: Bool = false
    
    ///Variable that determines how much to to slow down velocity
    var slowFactor: Float = 1
    
    let animationAttackSpeed = 0.05
    let animationMovementSpeed = 0.1
    
    var movespeed: CGFloat = 250
    
    var destination: CGPoint = CGPointMake(0, 0)

    var activeAnimationKey = ""
    var direction = "Down"
    
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
    
    func initializeTextureArrays(){
        
    }
    
    //MARK: Update Loop
    func update(){
    }
    
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        
    }
    
//    func resolveAnimation(){
//        var animationFrames: [SKTexture] = []
//        var animationKey: String = ""
//        let animationState = self.requestedAnimation
//        
//        switch(animationState){
//            
//        case AnimationState.AttackDown:
//            animationKey = "attackDown"
//            animationFrames = downAttackTextures
//        
//        case AnimationState.AttackLeft:
//            animationKey = "attackLeft"
//            animationFrames = leftAttackTextures
//            
//        case AnimationState.AttackRight:
//            animationKey = "attackRight"
//            animationFrames = rightAttackTextures
//            
//        case AnimationState.AttackUp:
//            animationKey = "attackUp"
//            animationFrames = upAttackTextures
//            
//        case AnimationState.MoveLeft:
//            animationKey = "moveLeft"
//            animationFrames = leftMovementTextures
//                      
//        case AnimationState.MoveDown:
//            animationKey = "moveDown"
//            animationFrames = downMovementTextures
//            
//        case AnimationState.MoveUp:
//            animationKey = "moveUp"
//            animationFrames = upMovementTextures
//            
//        case AnimationState.MoveRight:
//            animationKey = "moveRight"
//            animationFrames = rightMovementTextures
//            
//        case AnimationState.Death:
//            animationKey = "death"
//            animationFrames = deathAnimationFrames
//            
//            
//        default:
//            break
//        }
//        
//        self.fireAnimation(animationState, textures: animationFrames, key: animationKey)
//        
//        self.requestedAnimation = self.isDying ? AnimationState.Death : AnimationState.Idle
//
//        
//    }
//    
//    func fireAnimation (animation: AnimationState, textures: [SKTexture], key: String){
//        var action = self.actionForKey(key)
//        if (action != nil || textures.count < 1){
//            return
//        }
//        
//        activeAnimationKey = key
//        self.runAction(SKAction.sequence(
//            [SKAction.animateWithTextures(textures, timePerFrame: animationSpeed, resize: true, restore: false),
//            SKAction.runBlock({
//                self.animationHasCompleted(animation)
//            })
//            ]), withKey: key)
//    }
//    
//    func animationHasCompleted(state: AnimationState){
//
//        if (self.isDying){
//            
//        }
//        
//        self.animationDidComplete(state)
//        
//        if (self.isAttacking){
//            self.isAttacking = false
//        }
//        
//        self.activeAnimationKey = ""
//    }
//    
//    //Overridden
//    func animationDidComplete(state: AnimationState){
//        
//    }
    
    
    
    //MARK: Physics Bodies (Overridden)
    func configurePhysicsBody(){
        
    }
    
    func collidedWith (other: SKPhysicsBody){
        
    }
    
    //MARK: Applying Damage
    //TODO: Figure out pushback animations and how damage is applied
    func applyDamage(damage: Float) -> Bool{
        self.health -= damage
        
        if (self.health <= 0){
            self.performDeath()
            return true
        }
        
        return false
    }
    
    //MARK: Dying (Overriden)
    func performDeath(){
        self.health = 0.0
        self.isDying = true

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
            self.direction = "Up"
            attackAnimation = SKAction.animateWithTextures(upAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Down:
            self.direction = "Down"
            attackAnimation = SKAction.animateWithTextures(downAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Right:
            self.direction = "Right"
            attackAnimation = SKAction.animateWithTextures(rightAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case AttackDirection.Left:
            self.direction = "Left"
            attackAnimation = SKAction.animateWithTextures(leftAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        default:
            break
            
        }
        
        self.runAction(attackAnimation, completion: {
            self.isAttacking = false
        })
    }
    
    //MARK: Movement
    func stopMoving(){
        self.physicsBody?.velocity = CGVector.zeroVector
        var scene = self.scene as GameScene
        self.removeAllActions()
        self.destination = self.position
        
    }
    

    

}
