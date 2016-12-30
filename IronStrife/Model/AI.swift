//
//  File.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/30/16.
//  Copyright © 2016 Vinai Suresh. All rights reserved.
//

import UIKit

// MARK: - AI

protocol AI: class {
    var behavior: AIBehavior { get set }
    func changeBehavior(behavior: AIBehavior)
}

extension AI {
    func changeBehavior(behavior: AIBehavior) {
        self.behavior = behavior
    }
}

// MARK: - Enemy AI
protocol EnemyAI: AI {
    var chaseDistance: CGFloat { get }
    func distanceFromPlayer() -> CGFloat
    func attack()
}

extension EnemyAI where Self: Enemy {
    func distanceFromPlayer() -> CGFloat {
        let distance = MathFunctions.calculateDistance(self.position, point2: Player.sharedInstance.position)
        return CGFloat(distance)
    }
}

// MARK: - Moveable AI
protocol MoveableAI: AI {
    func moveTo(position: CGPoint)
    func stopMoving()
    func isMoving() -> Bool
}

extension MoveableAI where Self: Character {
    func isMoving() -> Bool {
        return action(forKey: currentMovementAnimationKey) != nil
    }
}

