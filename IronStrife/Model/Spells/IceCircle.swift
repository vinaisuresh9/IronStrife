//
//  IceSpell.swift
//  IronStrife
//
//  Created by Vinai Suresh on 1/5/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class IceCircle: SKSpriteNode {
    var counter: Int = 0
    var owner: Player?
    private let atlas = Textures.iceSpellTextures
    private var textures: [SKTexture] = []
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
    
    private struct slow { static var slow:Float = 40}
    class var slowSpeed: Float{
        get{ return slow.slow;}
        set{ slow.slow = newValue}
    }
    
    ///Initializes default IceCircle
    convenience init(owner: Player){
        self.init()
        self.owner = owner
        self.configurePhysicsBody()
        self.position = owner.position
        
        for (var i = 49; i >= 1; i-=3){
            textures.append(atlas.textureNamed("IceCircle\(i)"))
        }
        self.owner?.scene?.addChild(self)
    }
    
    
    private convenience override init(){
        self.init(texture: Textures.iceSpellTextures.textureNamed("IceCircle49"), color: UIColor.whiteColor(), size: Textures.iceSpellTextures.textureNamed("IceCircle49").size())
        
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhysicsBody(){
        self.setScale(0.8)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width/2)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = CollisionBitMask.Spell.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.Enemy.rawValue
        self.physicsBody?.dynamic = false

    }
    
    func run(){
        let animation = SKAction.animateWithTextures(textures, timePerFrame: animationTime, resize: true, restore: false)
        self.runAction(animation, completion: {
            self.removeFromParent()
        })
    }
    
    //MARK: Update Loop
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if (self.updateInterval <= timeSince){
            self.configurePhysicsBody()
        }
    }

}
