//
//  AttackBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation
import UIKit

class AttackBehavior: AIBehavior {
    fileprivate static var attackThreshold: CGFloat = 70
    
    func run(_ ai: AI) {
        if (enemy is Goreblon) {
            enemy.meleeAttack(enemy.directionToPlayer())
        }
        
        if (ChaseBehavior.checkPreconditions(enemy)) {
            enemy.changeState(ChaseBehavior())
        }
    }
    
    //TODO: Finish up precondition check
    static func checkPreconditions(_ ai: AI) -> Bool {
        if (enemy.distanceFromPlayer() < attackThreshold) {
            return true
        }
        
        return false
    }
}
