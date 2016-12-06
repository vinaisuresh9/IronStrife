//
//  Cure.swift
//  IronStrife
//
//  Created by Vinai Suresh on 1/14/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Cure: SKSpriteNode{
    
    var textures: [SKTexture] = []
    fileprivate let atlas = Textures.curespellTextures
    var owner: Player?
    fileprivate let animationTime = 0.03
    
    static var curePercent: Float = 40;
    static var spellCost: Float = 40;

    ///Initializes default Cure Spell
    convenience init(owner: Player){
        self.init(texture: Textures.curespellTextures.textureNamed("Cure1"))
        self.owner = owner
        self.position = owner.position
        
        for i in stride(from:1, through:17, by:1) {
            textures.append(atlas.textureNamed("Cure\(i)"))

        }

        self.owner?.scene?.addChild(self)
    }
    
    
    func run(){
        let animation = SKAction.animate(with: textures, timePerFrame: animationTime, resize: true, restore: false)
        self.run(animation, completion: {
            self.removeFromParent()
        })
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){
        if let owner = owner {
            self.position = owner.position
        }
    }
    
    
}
