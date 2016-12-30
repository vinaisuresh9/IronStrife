//
//  WanderBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import UIKit

class WanderBehavior: AIBehavior {
    fileprivate let maxWanderDistance: CGFloat = 100
    
    func run(_ ai: AI) {
         if let character = ai as? Character, character.action(forKey: character.currentMovementAnimationKey) == nil {
            let randomVariable = arc4random()
            let percentage: CGFloat = CGFloat(randomVariable % 100) / 100
            let randomAngle = Double(percentage) * 2 * M_PI
            if let destinationPoint = MathFunctions.point(withOrigin: character.position, distance: maxWanderDistance, angle: randomAngle) {
                character.moveTo(destinationPoint)
            }
        }
        
        if ChaseBehavior.checkPreconditions(ai) {
            ai.changeBehavior(behavior: ChaseBehavior())
        }
    }
    
    static func checkPreconditions(_ ai: AI) -> Bool {
        switch ai {
        case let enemy as EnemyAI:
            return enemy.distanceFromPlayer() > enemy.chaseDistance
        default:
            return false
        }
    }
}
