//
//  PhysicsBodyContaining.swift
//  IronStrife
//
//  Created by Vinai on 7/22/18.
//  Copyright © 2018 Vinai Suresh. All rights reserved.
//

import Foundation
import SpriteKit

protocol PhysicsBodyContaining where Self: SKNode {
    func configurePhysicsBody()
}
