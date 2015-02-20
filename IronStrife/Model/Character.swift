//
//  Character.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/26/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit


enum CollisionBitMask: UInt32 {
    case
    Player              = 1,
    PlayerProjectile    = 2,
    EnemyProjectile     = 4,
    Enemy               = 8,
    Other               = 16,
    Spell               = 32
    
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

    var currentMovementAnimationKey = ""
    var activeAnimationKey = ""
    var direction = "Down"
    
    var attackSoundPrefix = ""
    var numberAttackSounds:Int32 = 0
    
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
    
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if (self.actionForKey(currentMovementAnimationKey) != nil){
            checkDestination()
        }
    }
    
    
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
        self.runAction(SKAction.playSoundFileNamed(self.attackSoundPrefix + "\((rand() % self.numberAttackSounds) + 1).wav", waitForCompletion: false))
    }
    
    //MARK: Movement and Orientation
    func moveTo(point:CGPoint)
    {
        //var movementAction = SKAction.moveTo(scenePoint, duration: time)
        //player.runAction(movementAction, withKey: player.direction)
        
        let distance = MathFunctions.calculateDistance(self.position, point2: point)
        let time = distance/Double(self.movespeed)
        var velocity = MathFunctions.normalizedVector(self.position, point2: point)
        
        self.destination = point
        
        self.setDirection(point, moving: true)
        currentMovementAnimationKey = self.direction
        self.physicsBody?.velocity = CGVectorMake(velocity.dx * self.movespeed, velocity.dy * self.movespeed)

    }
    
    
    func reachedDestination() -> Bool{
        if (MathFunctions.calculateDistance(self.position, point2: destination) < 10){
            return true;
        }
        return false;
    }
    
    
    func checkDestination(){
        if (self.reachedDestination()){
            self.stopMoving()
            self.removeAllActions()
        }
    }
    
    
    func setDirection(scenepoint: CGPoint, moving: Bool) {
        
        //For the case where you have just shot a fireball
        if (self.physicsBody?.velocity == CGVector.zeroVector){
            self.direction = ""
        }
        let atlas = SKTextureAtlas(named: self.theClassName)
        var currentMovementTextures: [SKTexture] = []
        
        //Not the best math here but works
        let vector = MathFunctions.normalizedVector(self.position, point2: scenepoint)
        let angle = asinf(Float(vector.dy)/Float(1))
        switch(angle){
            
        case let a where angle >= Float(M_PI_4) && angle <= (3 * Float(M_PI_4)):
            if (self.direction == "Up"){
                return
            }
            direction = "Up"
            self.texture = atlas.textureNamed("Up1")
            currentMovementTextures = upMovementTextures
            
        case let a where angle <= Float(M_PI_4) && angle >= -Float(M_PI_4) && (scenepoint.x <= self.position.x):
            if (self.direction == "Left"){
                return
            }
            direction = "Left"
            self.texture = atlas.textureNamed("Left1")
            currentMovementTextures = leftMovementTextures
            
            
        case let a where angle <= -Float(M_PI_4) && angle >= -(3 * Float(M_PI_4)):
            if (self.direction == "Down"){
                return
            }
            direction = "Down"
            self.texture = atlas.textureNamed("Down1")
            currentMovementTextures = downMovementTextures
            
            
        default:
            if (self.direction == "Right"){
                return
            }
            direction = "Right"
            self.texture = atlas.textureNamed("Right1")
            currentMovementTextures = rightMovementTextures
            
        }
        if (moving){
            self.removeActionForKey(direction)
            let animateAction = SKAction.animateWithTextures(currentMovementTextures, timePerFrame: animationMovementSpeed, resize: true, restore: false)
            self.runAction(SKAction.repeatActionForever(animateAction), withKey: direction)
        }
        
    }
    
    
    func stopMoving(){
        self.physicsBody?.velocity = CGVector.zeroVector
        var scene = self.scene as GameScene
        self.removeAllActions()
        self.destination = self.position
        
    }
    

}
