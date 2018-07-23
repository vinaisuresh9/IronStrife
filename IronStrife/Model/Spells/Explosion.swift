//
//  Explosion.swift
//  IronStrife
//
//  Created by Vinai Suresh on 2/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Explosion: AoESpell {
    fileprivate let atlas = Textures.explosionTextures
    fileprivate let animationTime = 0.09
    fileprivate var updateInterval: TimeInterval{
        get{
            let frameRate = 1/(self.animationTime * Double(Textures.explosionTextures.textureNames.count))
            return animationTime/frameRate
        }
    }

    
    fileprivate var parentFireball: Fireball?
    
    //Always half damage of the fireball
    fileprivate struct attack {
        static var attack:Float {
            get {
                return Fireball.attackDamage/2
            }
        }
    }
    class var attackDamage: Float{
        get{ return attack.attack;}
    }
    
    ///Initializes default Explosion
    convenience init(fireball: Fireball){
        self.init(texture: Textures.explosionTextures.textureNamed("FireExplosion1"))
        self.parentFireball = fireball
        self.position = fireball.position
    
        for i in 1..<8{
            self.textures.append(atlas.textureNamed("FireExplosion\(i)"))
        }
        
        self.parentFireball?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animate(with: textures, timePerFrame: animationTime, resize: false, restore: false)
        self.run(SKAction.group([animation, Sounds.explosionSound])
            , completion: {
            self.removeFromParent()
        })
    }  
}

extension Explosion: FrameUpdatable {
    func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){
        if let fireballPosition = self.parentFireball?.position {
            self.position = fireballPosition
        }
    }
}
