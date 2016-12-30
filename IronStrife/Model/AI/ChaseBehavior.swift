//
//  ChaseBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation
import UIKit

class ChaseBehavior: AIBehavior {
    fileprivate static var chaseThreshold: CGFloat = 50
    
    func run(_ ai: AI) {
        guard let moveableAI = ai as? MoveableAI else { return }
        let player = Player.sharedInstance
        moveableAI.moveTo(position: player.position)
        
        if (AttackBehavior.checkPreconditions(ai)) {
            ai.changeBehavior(behavior: AttackBehavior())
        }
        if (WanderBehavior.checkPreconditions(ai)) {
            moveableAI.stopMoving()
            ai.changeBehavior(behavior: WanderBehavior())
        }
    }
    
    static func checkPreconditions(_ ai: AI) -> Bool {
        switch ai {
        case let enemy as EnemyAI:
            return enemy.distanceFromPlayer() < enemy.chaseDistance && enemy.distanceFromPlayer() > chaseThreshold
        default:
            return false
        }
    }
}
