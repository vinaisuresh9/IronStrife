//
//  Meeblon.swift
//  IronStrife
//
//  Created by Vinai Suresh on 1/4/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Meeblon: Enemy {
    convenience init(){
        self.init(texture: Textures.meeblonTextures.textureNamed("Down1"), color: UIColor.whiteColor(), size: Textures.meeblonTextures.textureNamed("Down1").size())
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.configurePhysicsBody()
        self.health = 100
        self.attackStrength = 15
        self.defense = 5
        self.colorBlendFactor = 0.5

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: PhysicsBody and Delegate
    override func configurePhysicsBody() {
        var center = CGPointZero
        center.y -= self.frame.height * 1/6
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width - 10, self.frame.height * 2/3), center: center)
        self.physicsBody!.allowsRotation = false;
        self.physicsBody!.collisionBitMask = CollisionBitMask.Enemy.rawValue | CollisionBitMask.Other.rawValue | CollisionBitMask.Player.rawValue | CollisionBitMask.PlayerProjectile.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.PlayerProjectile.rawValue | CollisionBitMask.Player.rawValue | CollisionBitMask.EnemyProjectile.rawValue
        self.physicsBody!.categoryBitMask = CollisionBitMask.Enemy.rawValue
        self.physicsBody?.mass = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        
    }
    
    //TODO: Check collision with Player Sword
    override func collidedWith(other: SKPhysicsBody) {
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
        
        for (var i = 2; i < 5; i++){
            downMovementTextures.append(atlas.textureNamed("Down\(i)"))
            rightMovementTextures.append(atlas.textureNamed("Right\(i)"))
            leftMovementTextures.append(atlas.textureNamed("Left\(i)"))
            upMovementTextures.append(atlas.textureNamed("Up\(i)"))
        }

        
    }
}
