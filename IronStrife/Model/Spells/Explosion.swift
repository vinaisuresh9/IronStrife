//
//  Explosion.swift
//  IronStrife
//
//  Created by Vinai Suresh on 2/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

let explosionAudioName = "Explosion.wav"

class Explosion: AoESpell {
    private let atlas = Textures.explosionTextures
    private let animationTime = 0.03
    private var updateInterval: NSTimeInterval{
        get{
            let frameRate = 1/(self.animationTime * Double(Textures.explosionTextures.textureNames.count))
            return animationTime/frameRate
        }
    }
    
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
    convenience init(owner: Player, fireball: Fireball){
        self.init(texture: Textures.explosionTextures.textureNamed("FireExplosion1"))
        self.owner = owner
        self.configurePhysicsBody()
        self.position = CGPointMake(200, 200)
        
        for (var i = 1; i < 8; i++){
            textures.append(atlas.textureNamed("FireExplosion\(i)"))
        }
        
        self.owner?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animateWithTextures(textures, timePerFrame: animationTime, resize: false, restore: false)
        let sound = SKAction.playSoundFileNamed(explosionAudioName, waitForCompletion: false)
        self.runAction(SKAction.group([animation, sound])
            , completion: {
            self.removeFromParent()
        })
    }
    
    
    //MARK: Update Loop
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        self.configurePhysicsBody()
        println(self.position)
    }
    
}
