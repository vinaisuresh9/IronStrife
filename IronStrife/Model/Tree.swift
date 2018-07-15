//
//  Tree.swift
//  IronStrife
//
//  Created by Vinai Suresh on 10/28/15.
//  Copyright © 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Tree: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configurePhysicsBody()
    }
    
    func configurePhysicsBody() {
        self.configureDefaultPhysicsBody()
        physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue | CollisionBitMask.player.rawValue | CollisionBitMask.enemyProjectile.rawValue | CollisionBitMask.playerProjectile.rawValue
        physicsBody?.categoryBitMask = CollisionBitMask.other.rawValue
    }

}
