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
    
    //This would be a class variable when supported (need to be set in subclasses
    private struct movespeed { static var moveSpeed:Float = 400}
    class var moveSpeed: Float{
        get{ return movespeed.moveSpeed;}
        set{ movespeed.moveSpeed = newValue}
    }
    
    private struct attack { static var attack:Float = 25}
    class var attackDamage: Float{
        get{ return attack.attack;}
        set{ attack.attack = newValue}
    }
    
    private struct cost { static var cost:Float = 15}
    class var spellCost: Float{
        get{ return cost.cost;}
        set{ cost.cost = newValue}
    }

    //MARK: Initializer
    ///Initializes default firemagic icon
    convenience init(direction: CGPoint, owner: Player){
        self.init(texture: Textures.fireballTexture)
        self.owner = owner
        self.configurePhysicsBody()
        self.direction = direction
        self.position = owner.position
        self.zRotation = CGFloat(MathFunctions.angleFromLine(self.position, point2: direction)!)
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.removeFromParent()]))
        let normalVector = MathFunctions.normalizedVector(self.position, point2: direction)
        self.physicsBody?.velocity = CGVectorMake(normalVector.dx * CGFloat(Fireball.moveSpeed), normalVector.dy * CGFloat(Fireball.moveSpeed))
    }
    
    
    //MARK:Explosion
    func explode() {
//        var explosion = Explosion(fireball: self)
//        explosion.run()
        self.removeFromParent()
    }
    
}
