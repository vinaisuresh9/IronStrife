//
//  ChaseBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation

class ChaseBehavior: AIBehavior {
    var player = Player.sharedInstance
    
    func run(_ enemy: Enemy) {
        enemy.moveTo(player.position)
        
        if (AttackBehavior.checkPreconditions(enemy)) {
            enemy.changeState(AttackBehavior())
        }
        if (WanderBehavior.checkPreconditions(enemy)) {
            enemy.changeState(WanderBehavior())
        }
    }
    
    static func checkPreconditions(_ enemy: Enemy) -> Bool {
        if (enemy.distanceFromPlayer() < enemyChaseDistance && enemy.distanceFromPlayer() > 70) {
            return true
        }
        
        return false
    }
}
