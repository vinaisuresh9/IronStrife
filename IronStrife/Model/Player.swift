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
    
    static var maxHealth: Float = 200
    static var maxMana: Float = 100
    
    override var health: Float {
        didSet {
            if (health > Player.maxHealth) {
                health = Player.maxHealth
            }
        }
    }
    
    override var mana: Float {
        didSet {
            if (mana > Player.maxMana) {
                mana = Player.maxMana
            }
        }
    }

    //MARK: Initialization 
    convenience init(){
        self.init(texture: Textures.playerTextures.textureNamed("Down1"))

        configurePhysicsBody()
        initializeTextureArrays()

        self.configureStats()
        self.attackSoundPrefix = "PlayerAttack"
        self.numberAttackSounds = 10
        preloadSounds()
        
    }
    
    override func configureStats() {
        self.health = 200
        self.mana = 100
        self.attackStrength = 25
        self.defense = 10
        self.movespeed = 250
    }
    
    func configurePhysicsBody() {
        super.configureDefaultPhysicsBody()
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue | CollisionBitMask.other.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.enemyProjectile.rawValue
        self.physicsBody?.categoryBitMask = CollisionBitMask.player.rawValue
    }
    
    
    
    override func initializeTextureArrays(){
        let atlas = Textures.playerTextures
        
        for i in 2..<5 {
            downMovementTextures.append(atlas.textureNamed("Down\(i)"))
            rightMovementTextures.append(atlas.textureNamed("Right\(i)"))
            leftMovementTextures.append(atlas.textureNamed("Left\(i)"))
            upMovementTextures.append(atlas.textureNamed("Up\(i)"))
        }
        
        for j in 1..<6 {
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

    - parameter cost: current spell cost
    - returns: true of available or false if not

    */
    func checkMana(_ cost: Float) -> Bool{
        if (self.mana > cost){
            return true
        }
        return false
    }
    
    func castFireball(_ point: CGPoint ) {
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
        
        let cure = Cure(owner: self)
        cure.run()
        
        self.health += (Cure.curePercent * Player.maxHealth)
        
    }
    
    
    //MARK: Attacking
    /// Attack for Player
    func attackInDirection (_ direction: UISwipeGestureRecognizerDirection){
        switch (direction){
            
        case UISwipeGestureRecognizerDirection.up:
            self.meleeAttack(.Up)
            
        case UISwipeGestureRecognizerDirection.down:
            self.meleeAttack(.Down)
            
        case UISwipeGestureRecognizerDirection.right:
            self.meleeAttack(.Right)
            
        case UISwipeGestureRecognizerDirection.left:
            self.meleeAttack(.Left)
            
        default:
            break
            
        }
    }
}

extension Player: ChildFrameUpdating {
    var updateableChildren: [SKNode & FrameUpdatable] {
        let sceneChildren = scene?.children
        return (sceneChildren?.filter{ $0 is IceCircle || $0 is Cure || $0 is Fireball } as? [SKNode & FrameUpdatable]) ?? []
    }

    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval) {
        super.updateWithTimeSinceLastUpdate(timeSince)
        for child in updateableChildren {
            child.updateWithTimeSinceLastUpdate(timeSince)
        }
    }
}
