//
//  ChaseBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation

class ChaseBehavior: AIBehavior {
    
    func run(_ enemy: Enemy) {
        let player = Player.sharedInstance
        enemy.moveTo(player.position)
        
        if (AttackBehavior.checkPreconditions(enemy)) {
            enemy.changeState(AttackBehavior())
        }
        if (WanderBehavior.checkPreconditions(enemy)) {
            enemy.stopMoving()
            enemy.changeState(WanderBehavior())
        }
    }
    
    static func checkPreconditions(_ enemy: Enemy) -> Bool {
        if (enemy.distanceFromPlayer() < enemy.enemyChaseDistance && enemy.distanceFromPlayer() > 70) {
            return true
        }
        
        return false
    }
}
