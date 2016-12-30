//
//  IceSpell.swift
//  IronStrife
//
//  Created by Vinai Suresh on 1/5/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

let iceAudioName = "IceCircle.wav"

class IceCircle: AoESpell {
    fileprivate let atlas = Textures.icespellTextures
    fileprivate let animationTime = 0.03
    fileprivate var updateInterval: TimeInterval{
        get{
            let frameRate = 1/(animationTime * Double(Textures.icespellTextures.textureNames.count))
            return animationTime/frameRate
        }
    }
    
    static var attackDamage:Float = 10
    
    static var spellCost:Float = 60
    
    static var slowFactor:Float = 0.4
    
    ///Initializes default IceCircle
    convenience init(owner: Player){
        self.init(texture: Textures.icespellTextures.textureNamed("IceCircle49"))
        self.owner = owner
        configurePhysicsBody()
        position = owner.position
        
        for i in stride(from:49, through:1, by: -3) {
            textures.append(atlas.textureNamed("IceCircle\(i)"))

        }
        
        self.owner?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animate(with: textures, timePerFrame: animationTime, resize: true, restore: false)
        let sound = SKAction.playSoundFileNamed(iceAudioName, waitForCompletion: false)
        run(SKAction.group([animation, sound])
            , completion: {
            self.removeFromParent()
        })
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){
        if (updateInterval <= timeSince){
            configurePhysicsBody()
        }
    }

}
