//
//  Enemy.swift
//  IronStrife
//
//  Created by Vinai Suresh on 9/7/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

enum AttackType{
    case melee,
    range
}

let explosionHitCoolDown: Double = 2
let iceCircleHitCoolDown: Double = 3

class Enemy: Character {
    let chaseDistance: CGFloat = 250
    
    var type: AttackType = AttackType.melee
    var hitByIce = false
    var hitByExplosion = false
    // AI
    var behavior: AIBehavior = WanderBehavior()

    override func collidedWith(_ other: SKPhysicsBody) {
        if (isDying){
            return
        }
        let otherNode = other.node
        if (otherNode is Fireball){
            let killed = applyDamage(Fireball.attackDamage)
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
            
            slowFactor = 1 - IceCircle.slowFactor
            color = UIColor.blue
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
            
            let killed = applyDamage(Explosion.attackDamage)
            color = UIColor.red
            hitByExplosion = true
            
            let delayTime = DispatchTime.now() + Double(Int64(explosionHitCoolDown * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.hitByExplosion = false
                self.color = UIColor.white
            }
        } else if (other.categoryBitMask == CollisionBitMask.wall.rawValue) {
            stopMoving()
        }
        
    }
    
    //MARK: Distance Functions
    
    fileprivate func directionToPlayer() -> Direction {
        return directionToPoint(Player.sharedInstance.position)
    }
    
    //MARK: Update Loop
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval) {
        super.updateWithTimeSinceLastUpdate(timeSince)
        
        behavior.run(self)
    }
}

// MARK: - EnemyAI
extension Enemy: EnemyAI {
    func attack() {
        switch type {
        case .melee:
            meleeAttack(directionToPlayer())
        case .range:
            // TODO: Support ranged attacking
            break
        }
    }
}

// MARK: - MoveableAI
extension Enemy: MoveableAI {}
