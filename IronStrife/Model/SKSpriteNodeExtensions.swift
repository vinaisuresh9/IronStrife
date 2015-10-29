//
//  SKSpriteNodeExtensions.swift
//  IronStrife
//
//  Created by Vinai Suresh on 10/28/15.
//  Copyright © 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

extension SKSpriteNode  {
    func configurePhysicsBody() {
        var center = CGPointZero
        center.y -= self.frame.height * 1/6
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width - 15, self.frame.height * 2/3), center: center)
        self.physicsBody?.mass = 0
        self.setScale(0.8)
        self.physicsBody!.allowsRotation = false;
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
    }
}
