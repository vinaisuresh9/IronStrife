//
//  Fireball.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/19/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Fireball: Projectile{
    var direction = CGPoint.zero
    
    static var moveSpeed:Float = 400
    
    static var attackDamage:Float = 25
    
    static var spellCost:Float = 15

    //MARK: Initializer
    ///Initializes default firemagic icon
    convenience init(direction: CGPoint, owner: Player){
        self.init(texture: Textures.fireballTexture)
        self.owner = owner
        self.configurePhysicsBody()
        self.direction = direction
        self.position = owner.position
        self.zRotation = CGFloat(MathFunctions.angleFromLine(self.position, point2: direction)!)
        self.run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()]))
        let normalVector = MathFunctions.normalizedVector(self.position, point2: direction)
        self.physicsBody?.velocity = CGVector(dx: normalVector.dx * CGFloat(Fireball.moveSpeed), dy: normalVector.dy * CGFloat(Fireball.moveSpeed))
    }
    
    
    //MARK:Explosion
    func explode() {
        let explosion = Explosion(fireball: self)
        explosion.run()
        self.removeFromParent()
    }
    
}
