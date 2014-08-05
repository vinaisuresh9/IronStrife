//
//  Player.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    let movespeed = Double(300)
    
    class var sharedInstance: Player {
    struct Singleton {
        static let instance = Player()
        }
        return Singleton.instance
    }
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
    
    convenience override init(){
        self.init(imageNamed: "Player1")

    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    //TODO: Would check available mana before this
    func castFireball(point: CGPoint ) -> (Fireball?,[SKAction]) {
        let normalVector = MathFunctions.normalizedVector(self.position, point2: point)
        
        let fire = Fireball(direction: normalVector)
        fire.position = self.position
        fire.zRotation = CGFloat(MathFunctions.angleToRotateFromLine(self.position, point2: point)!)
        let endpoint = CGPointMake(fire.position.x + 2000 * fire.direction.dx, fire.position.y + 2000 * fire.direction.dy)
        let distance = MathFunctions.calculateDistance(fire.position, point2: endpoint)
        let actionMove = SKAction.moveTo(endpoint, duration:  (distance / fireballMoveSpeed))
        let actionEnd = SKAction.removeFromParent()
        var moves: [SKAction] = [actionMove,actionEnd]

        //Returns instantiated fireball for drawing, as well as the point to which it should move
        return (fire, moves)
    }
    
    
    
    
}
