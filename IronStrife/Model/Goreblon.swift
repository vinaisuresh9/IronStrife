  //
//  Goreblon.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/27/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

let goreblonDeathSound = "GoreblonDeath.wav"

class Goreblon: Enemy {
    
    convenience init(){
        self.init(texture: Textures.goreblonTextures.textureNamed("Down1"), color: UIColor.whiteColor(), size: Textures.goreblonTextures.textureNamed("Down1").size())
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.configurePhysicsBody()
        self.initializeTextureArrays()
        self.configureStats()
        self.attackSoundPrefix = "GoreblonAttack"
        self.numberAttackSounds = 3
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func configureStats() {
        self.movespeed = 150
        self.health = 100
        self.attackStrength = 15
        self.defense = 5
        self.colorBlendFactor = 0.5
    }
    
    //MARK: PhysicsBody and Delegate
    override func configurePhysicsBody() {
        super.configurePhysicsBody()
        self.physicsBody!.collisionBitMask = CollisionBitMask.Enemy.rawValue | CollisionBitMask.Other.rawValue | CollisionBitMask.Player.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Player.rawValue
        self.physicsBody!.categoryBitMask = CollisionBitMask.Enemy.rawValue
        
    }
    
    //TODO: Check collision with Player Sword
    override func collidedWith(other: SKPhysicsBody) {
        super.collidedWith(other)
    }
    
    //MARK: Death
    override func performDeath() {
        super.performDeath()
        
        //TODO: Death Animation
        let soundAction = SKAction.playSoundFileNamed(goreblonDeathSound, waitForCompletion: false)
        
        self.runAction(soundAction, completion: { () -> Void in
            self.removeFromParent()
        })
        
    }
    
    //MARK: Setup
    override func initializeTextureArrays(){
        let atlas = Textures.goreblonTextures
        
        for (var i = 2; i < 5; i++){
            downMovementTextures.append(atlas.textureNamed("Down\(i)"))
            rightMovementTextures.append(atlas.textureNamed("Right\(i)"))
            leftMovementTextures.append(atlas.textureNamed("Left\(i)"))
            upMovementTextures.append(atlas.textureNamed("Up\(i)"))
        }
        
        for (var j = 1; j < 5; j++){
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
    

    

}
