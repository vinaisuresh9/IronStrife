//
//  Player.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Player: Character {
    
    
    class var sharedInstance: Player {
    struct Singleton {
        static let instance = Player()
        }
        return Singleton.instance
    }

    
    var currentMovementTextures: [SKTexture] = []

    convenience override init(){
        
        self.init(texture: Textures.playerTextures.textureNamed("Down1"))
        configurePhysicsBody()
        initializeTextureArrays()
        self.health = 200
        self.mana = 100
        self.attackStrength = 25
        self.defense = 10
        
    }
    
    override func configurePhysicsBody() {
        var center = CGPointZero
        center.y -= self.frame.height * 1/6
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width - 10, self.frame.height * 2/3), center: center)
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.collisionBitMask = CollisionBitMask.Enemy.rawValue | CollisionBitMask.Other.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.EnemyProjectile.rawValue
        self.physicsBody?.categoryBitMask = CollisionBitMask.Player.rawValue
        self.physicsBody?.mass = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
    }
    
    override func initializeTextureArrays(){
        let atlas = Textures.playerTextures
        
        for (var i = 2; i < 5; i++){
            downMovementTextures.append(atlas.textureNamed("Down\(i)"))
            rightMovementTextures.append(atlas.textureNamed("Right\(i)"))
            leftMovementTextures.append(atlas.textureNamed("Left\(i)"))
            upMovementTextures.append(atlas.textureNamed("Up\(i)"))
        }
        
        for (var j = 1; j < 6; j++){
            leftAttackTextures.append(atlas.textureNamed("LeftAttack\(j)"))
            rightAttackTextures.append(atlas.textureNamed("RightAttack\(j)"))
            upAttackTextures.append(atlas.textureNamed("UpAttack\(j)"))
            downAttackTextures.append(atlas.textureNamed("DownAttack\(j)"))
        }

        
        leftAttackTextures.append(atlas.textureNamed("Left1"))
        upAttackTextures.append(atlas.textureNamed("Up1"))
        rightAttackTextures.append(atlas.textureNamed("Right1"))
        downAttackTextures.append(atlas.textureNamed("Down1"))
        
    }
    
    //MARK: Spells
    /**
    Checks available mana

    :param: cost current spell cost
    :returns: true of available or false if not

    */
    func checkMana(cost: Float) -> Bool{
        if (self.mana > cost){
            return true
        }
        return false
    }
    
    func castFireball(point: CGPoint ) {
        if (!checkMana(Fireball.spellCost)){
            return
        }
        
        self.stopMoving()
        self.setDirection(point, moving: false)
        let fire = Fireball(direction: point, owner: self)
        self.scene?.addChild(fire)
    }
    
    
    //MARK: Moving and Orientation
    func setDirection(scenepoint: CGPoint, moving: Bool) {
        
        //For the case where you have just shot a fireball
        if (self.physicsBody?.velocity == CGVector.zeroVector){
            self.direction = ""
        }
        let atlas = Textures.playerTextures
        
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
    
    func reachedDestination() -> Bool{
        if (MathFunctions.calculateDistance(self.position, point2: destination) < 10){
            return true;
        }
        return false;
    }
    
    //MARK: Attacking
    /// Attack for Player
    func attackInDirection (direction: UISwipeGestureRecognizerDirection){
        switch (direction){
            
        case UISwipeGestureRecognizerDirection.Up:
            self.meleeAttack(AttackDirection.Up)
            
        case UISwipeGestureRecognizerDirection.Down:
            self.meleeAttack(AttackDirection.Down)
            
        case UISwipeGestureRecognizerDirection.Right:
            self.meleeAttack(AttackDirection.Right)
            
        case UISwipeGestureRecognizerDirection.Left:
            self.meleeAttack(AttackDirection.Left)
            
        default:
            break
            
        }
    }

    
    
    
    
}
