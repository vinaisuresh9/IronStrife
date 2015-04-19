//
//  WanderBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation

class WanderBehavior: AIBehavior {
    var player = Player.sharedInstance
    
    func run(enemy: Enemy) {
        enemy.stopMoving()
        
        if (ChaseBehavior.checkPreconditions(enemy)) {
            enemy.changeState(ChaseBehavior())
        }
    }
    
    static func checkPreconditions(enemy: Enemy) -> Bool {
        if (enemy.distanceFromPlayer() > enemyChaseDistance) {
            return true
        }
        
        return false
    }
}