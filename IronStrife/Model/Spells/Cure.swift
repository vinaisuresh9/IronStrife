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
    private let atlas = Textures.cureSpellTextures
    var owner: Player?
    private let animationTime = 0.03
    
    private struct cure  { static var cure:Float = 40}
    class var curePercent: Float{
        get{ return cure.cure;}
        set{ cure.cure = newValue}
    }
    
    private struct cost { static var cost:Float = 40}
    class var spellCost: Float{
        get{ return cost.cost;}
        set{ cost.cost = newValue}
    }

    ///Initializes default Cure Spell
    convenience init(owner: Player){
        self.init()
        self.owner = owner
        self.position = owner.position
        
        for (var i = 1; i <= 17; i++){
            textures.append(atlas.textureNamed("Cure\(i)"))
        }
        self.owner?.scene?.addChild(self)
    }
    
    
    private convenience override init(){
        self.init(texture: Textures.iceSpellTextures.textureNamed("Cure1"), color: UIColor.whiteColor(), size: Textures.iceSpellTextures.textureNamed("Cure1").size())
        
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func run(){
        let animation = SKAction.animateWithTextures(textures, timePerFrame: animationTime, resize: true, restore: false)
        self.runAction(animation, completion: {
            self.removeFromParent()
        })
    }
    
    //MARK: Update Loop
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if let owner = owner?{
            self.position = owner.position
        }
    }
    
    
}
