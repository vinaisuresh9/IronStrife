//
//  AttackBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/19/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation

class AttackBehavior: AIBehavior {
    var player = Player.sharedInstance    
    
    func run(_ enemy: Enemy) {
        if (enemy is Goreblon) {
            enemy.meleeAttack(enemy.directionToPlayer())
        }
        
        if (ChaseBehavior.checkPreconditions(enemy)) {
            enemy.changeState(ChaseBehavior())
        }
    }
    
    //TODO: Finish up precondition check
    static func checkPreconditions(_ enemy: Enemy) -> Bool {
        if (enemy.distanceFromPlayer() < 70) {
            return true
        }
        
        return false
    }
}
