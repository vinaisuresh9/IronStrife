//
//  Enemy.swift
//  IronStrife
//
//  Created by Vinai Suresh on 9/7/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

let enemyChaseDistance:CGFloat = 250

enum AttackType{
    case Melee,
    Range
}

class Enemy: Character {
    var type: AttackType = AttackType.Melee
    var hitByIce = false
    var hitByExplosion = false
    var state: AIBehavior = WanderBehavior()

    override func collidedWith(other: SKPhysicsBody) {
        if (self.isDying){
            return
        }
        let otherNode = other.node
        if (otherNode is Fireball){
            let killed = self.applyDamage(Fireball.attackDamage)
            let fireball = otherNode as! Fireball
            fireball.explode()
            if (killed){
                //TODO: Add score and EXP to player
            }
        }
        else if (otherNode is IceCircle){
            if (hitByIce){
                return
            }
            let killed = self.applyDamage(IceCircle.attackDamage)
            self.slowFactor = 1 - IceCircle.slowSpeed
            self.colorBlendFactor = 0.5
            self.color = UIColor.blueColor()
            hitByIce = true
            //Can only be hit by ice once in 5 seconds
            //TODO: Set timer for being hit by ice
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.hitByIce = false
                self.color = UIColor.whiteColor()
                self.slowFactor = 1
            }
            
        }
    }
    
    //MARK: Distance Functions
    func distanceFromPlayer() -> CGFloat {
        var distance = MathFunctions.calculateDistance(self.position, point2: Player.sharedInstance.position)
        return CGFloat(distance)
    }
    
    func directionToPlayer() -> Direction {
        return self.directionToPoint(Player.sharedInstance.position)
    }
    
    //MARK: State Switching
    func changeState(state: AIBehavior) {
        self.state = state
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval) {
        super.updateWithTimeSinceLastUpdate(timeSince)
        
        self.state.run(self)
    }
    
}
