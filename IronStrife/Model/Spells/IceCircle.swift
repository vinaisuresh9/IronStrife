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
    private let atlas = Textures.iceSpellTextures
    private let animationTime = 0.03
    private var updateInterval: NSTimeInterval{
        get{
            let frameRate = 1/(self.animationTime * Double(Textures.iceSpellTextures.textureNames.count))
            return animationTime/frameRate
        }
    }
    
    private struct attack { static var attack:Float = 10}
    class var attackDamage: Float{
        get{ return attack.attack;}
        set{ attack.attack = newValue}
    }
    
    private struct cost { static var cost:Float = 60}
    class var spellCost: Float{
        get{ return cost.cost;}
        set{ cost.cost = newValue}
    }
    
    private struct slow { static var slow:Float = 0.4}
    class var slowFactor: Float{
        get{ return slow.slow;}
        set{ slow.slow = newValue}
    }
    
    ///Initializes default IceCircle
    convenience init(owner: Player){
        self.init(texture: Textures.explosionTextures.textureNamed("IceCircle49"))
        self.owner = owner
        self.configurePhysicsBody()
        self.position = owner.position
        
        for (var i = 49; i >= 1; i-=3){
            textures.append(atlas.textureNamed("IceCircle\(i)"))
        }
        self.owner?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animateWithTextures(textures, timePerFrame: animationTime, resize: true, restore: false)
        let sound = SKAction.playSoundFileNamed(iceAudioName, waitForCompletion: false)
        self.runAction(SKAction.group([animation, sound])
            , completion: {
            self.removeFromParent()
        })
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if (self.updateInterval <= timeSince){
            self.configurePhysicsBody()
        }
    }

}
