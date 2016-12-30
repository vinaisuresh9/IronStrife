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
        switch ai {
        case let enemy as EnemyAI:
            enemy.attack()
        default:
            break
        }
        
        if (ChaseBehavior.checkPreconditions(ai)) {
            ai.changeBehavior(behavior: ChaseBehavior())
        }
    }
    
    //TODO: Finish up precondition check
    static func checkPreconditions(_ ai: AI) -> Bool {
        switch ai {
        case let enemy as EnemyAI:
            return enemy.distanceFromPlayer() < attackThreshold
        default:
            return false
        }
    }
}
