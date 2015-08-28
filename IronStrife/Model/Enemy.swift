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

let explosionHitCoolDown: Double = 2
let iceCircleHitCoolDown: Double = 3

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
            
            self.slowFactor = 1 - IceCircle.slowFactor
            self.color = UIColor.blueColor()
            hitByIce = true
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(iceCircleHitCoolDown * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.hitByIce = false
                self.color = UIColor.whiteColor()
                self.slowFactor = 1
            }
        }
        else if (otherNode is Explosion) {
            if (hitByExplosion) {
                return
            }
            
            let killed = self.applyDamage(Explosion.attackDamage)
            self.color = UIColor.redColor()
            hitByExplosion = true
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(explosionHitCoolDown * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.hitByExplosion = false
                self.color = UIColor.whiteColor()
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
