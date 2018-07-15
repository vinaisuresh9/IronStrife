//
//  SKSpriteNodeExtensions.swift
//  IronStrife
//
//  Created by Vinai Suresh on 10/28/15.
//  Copyright © 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

extension SKSpriteNode  {
    func configureDefaultPhysicsBody() {
        var center = CGPoint.zero
        center.y -= self.frame.height * 1/6
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width - 15, height: self.frame.height * 2/3), center: center)
        physicsBody?.mass = 0
        setScale(0.8)
        physicsBody?.allowsRotation = false;
        physicsBody?.restitution = 0
        physicsBody?.angularDamping = 0
        physicsBody?.linearDamping = 0
        physicsBody?.friction = 0
    }
}
