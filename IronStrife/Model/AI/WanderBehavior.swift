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
    
    func run(_ enemy: Enemy) {
         if enemy.action(forKey: enemy.currentMovementAnimationKey) == nil {
            let randomVariable = arc4random()
            let percentage: CGFloat = CGFloat(randomVariable % 100) / 100
            let randomAngle = Double(percentage) * 2 * M_PI
            if let destinationPoint = MathFunctions.point(withOrigin: enemy.position, distance: maxWanderDistance, angle: randomAngle) {
                enemy.moveTo(destinationPoint)
            }
        }
        
        if (ChaseBehavior.checkPreconditions(enemy)) {
            enemy.stopMoving()
            enemy.changeState(ChaseBehavior())
        }
    }
    
    static func checkPreconditions(_ enemy: Enemy) -> Bool {
        if (enemy.distanceFromPlayer() > enemy.enemyChaseDistance) {
            return true
        }
        
        return false
    }
}
