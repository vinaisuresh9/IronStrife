//
//  Fireball.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/19/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit


class Fireball: Projectile{
    var direction = CGPointZero
    
    //This would be a class variable when supported
    private struct movespeed { static var moveSpeed:CGFloat = 400}
    class var moveSpeed: CGFloat{
        get{ return movespeed.moveSpeed;}
        set{ movespeed.moveSpeed = newValue}
    }
    
    private struct attack { static var attack:CGFloat = 20}
    class var attackDamage: CGFloat{
        get{ return attack.attack;}
        set{ attack.attack = newValue}
    }
    
    convenience init(direction: CGPoint, owner: Character){
        self.init()
        self.owner = owner
        self.configurePhysicsBody()
        self.direction = direction
        self.position = owner.position
        self.zRotation = CGFloat(MathFunctions.angleFromLine(self.position, point2: direction)!)
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.removeFromParent()]))
        let normalVector = MathFunctions.normalizedVector(self.position, point2: direction)
        self.physicsBody?.velocity = CGVectorMake(normalVector.dx * Fireball.moveSpeed, normalVector.dy * Fireball.moveSpeed)
    }
    ///Initializes default firemagic icon
    private convenience override init(){
        self.init(texture: Textures.fireballTexture, color: UIColor.whiteColor(), size: Textures.fireballTexture.size())
        
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
}
