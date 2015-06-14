//
//  Explosion.swift
//  IronStrife
//
//  Created by Vinai Suresh on 2/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

let explosionSound = SKAction.playSoundFileNamed("Explosion.wav", waitForCompletion: false)


class Explosion: AoESpell {
    private let atlas = Textures.explosionTextures
    private let animationTime = 0.09
    private var updateInterval: NSTimeInterval{
        get{
            let frameRate = 1/(self.animationTime * Double(Textures.explosionTextures.textureNames.count))
            return animationTime/frameRate
        }
    }

    
    private var parentFireball: Fireball?
    
    //Always half damage of the fireball
    private struct attack {
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
        self.configurePhysicsBody()
        self.parentFireball = fireball
        self.position = fireball.position
    
        for (var i = 1; i < 8; i++){
            self.textures.append(atlas.textureNamed("FireExplosion\(i)"))
        }
        
        self.parentFireball?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animateWithTextures(textures, timePerFrame: animationTime, resize: false, restore: false)
        self.runAction(SKAction.group([animation, explosionSound])
            , completion: {
            self.removeFromParent()
        })
    }
    
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if let fireballPosition = self.parentFireball?.position {
            self.position = fireballPosition
        }
    }
    
}
