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
    case melee,
    range
}

let explosionHitCoolDown: Double = 2
let iceCircleHitCoolDown: Double = 3

class Enemy: Character {
    var type: AttackType = AttackType.melee
    var hitByIce = false
    var hitByExplosion = false
    var state: AIBehavior = WanderBehavior()

    override func collidedWith(_ other: SKPhysicsBody) {
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
            
            _ = self.applyDamage(IceCircle.attackDamage)
            
            self.slowFactor = 1 - IceCircle.slowFactor
            self.color = UIColor.blue
            hitByIce = true
            
            let delayTime = DispatchTime.now() + Double(Int64(iceCircleHitCoolDown * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.hitByIce = false
                self.color = UIColor.white
                self.slowFactor = 1
            }
        }
        else if (otherNode is Explosion) {
            if (hitByExplosion) {
                return
            }
            
            let killed = self.applyDamage(Explosion.attackDamage)
            self.color = UIColor.red
            hitByExplosion = true
            
            let delayTime = DispatchTime.now() + Double(Int64(explosionHitCoolDown * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.hitByExplosion = false
                self.color = UIColor.white
            }
        }
        
    }
    
    //MARK: Distance Functions
    func distanceFromPlayer() -> CGFloat {
        let distance = MathFunctions.calculateDistance(self.position, point2: Player.sharedInstance.position)
        return CGFloat(distance)
    }
    
    func directionToPlayer() -> Direction {
        return self.directionToPoint(Player.sharedInstance.position)
    }
    
    //MARK: State Switching
    func changeState(_ state: AIBehavior) {
        self.state = state
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval) {
        super.updateWithTimeSinceLastUpdate(timeSince)
        
        self.state.run(self)
    }
    
}
