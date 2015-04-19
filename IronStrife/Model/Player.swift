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

    //MARK: Initialization 
    convenience init(){
        
        self.init(texture: Textures.playerTextures.textureNamed("Down1"))
        self.position = position
        configurePhysicsBody()
        initializeTextureArrays()
        self.health = 200
        self.mana = 100
        self.attackStrength = 25
        self.defense = 10
        self.movespeed = 250
        self.attackSoundPrefix = "PlayerAttack"
        self.numberAttackSounds = 10
        
    }
    
    override func configurePhysicsBody() {
        self.setScale(0.8)
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
        self.setDirection(self.directionToPoint(point))
        let fire = Fireball(direction: point, owner: self)
        self.scene?.addChild(fire)
    }
    
    func castIceSpell(){
        if (!checkMana(IceCircle.spellCost)){
            return
        }
        
        self.stopMoving()
        let ice = IceCircle(owner: self)
        ice.run()

    }
    
    //TODO: Check max health and add healthback
    func castCureSpell(){
        if (!checkMana(Cure.spellCost)){
            return
        }
        
        //self.stopMoving()
        let cure = Cure(owner: self)
        cure.run()
    }
    
    
    //MARK: Attacking
    /// Attack for Player
    func attackInDirection (direction: UISwipeGestureRecognizerDirection){
        switch (direction){
            
        case UISwipeGestureRecognizerDirection.Up:
            self.meleeAttack(.Up)
            
        case UISwipeGestureRecognizerDirection.Down:
            self.meleeAttack(.Down)
            
        case UISwipeGestureRecognizerDirection.Right:
            self.meleeAttack(.Right)
            
        case UISwipeGestureRecognizerDirection.Left:
            self.meleeAttack(.Left)
            
        default:
            break
            
        }
    }
    
    
    //MARK: UpdateLoop
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval) {
        super.updateWithTimeSinceLastUpdate(timeSince)
        if let sceneChildren = self.scene?.children{
            for child in sceneChildren{
                if (child is IceCircle || child is Cure || child is Explosion){
                    child.updateWithTimeSinceLastUpdate(timeSince)
                }
            }
        }
    }

    
    
    
    
}
