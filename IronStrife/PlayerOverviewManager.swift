//
//  PlayerOverviewManager.swift
//  IronStrife
//
//  Created by Vinai Suresh on 5/14/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import Foundation
import SpriteKit

let playerHealthDecreasedNotification = "playerHealthDecreasedNotification"
let playerHealthIncreasedNotification = "playerHealthIncreasedNotification"
let playerManaDecreasedNotification = "playerManaDecreasedNotification"
let playerManaIncreasedNotification = "playerManaIncreasedNotification"

class PlayerOverviewManager: NSObject {
    
    var currentScene: GameScene? {
        didSet {
            self.configureOverlay()
        }
    }
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "healthDecreased", name: playerHealthDecreasedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "healthIncreased", name: playerHealthIncreasedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "manaDecreased", name: playerManaDecreasedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "manaIncreased", name: playerManaIncreasedNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func configureOverlay() {
        _ = SKShapeNode()
        //border.path = UIBezierPath.
        
        let healthBar = SKSpriteNode(imageNamed: "HealthBar.png")
        healthBar.setScale(0.6)
        healthBar.colorBlendFactor = 1
        healthBar.color = UIColor.greenColor()
        if let height = self.currentScene?.frame.size.height {
            healthBar.position = CGPointMake(150, height - 150)
        }
        self.currentScene?.addChild(healthBar)
        healthBar.zPosition = 1
        
        
        let manaBar = SKSpriteNode(imageNamed: "HealthBar.png")
        manaBar.setScale(0.6)
        manaBar.colorBlendFactor = 1
        manaBar.color = UIColor.blueColor()
        if let width = self.currentScene?.frame.size.width,
            let height = self.currentScene?.frame.size.height {
            manaBar.position = CGPointMake(width - 150, height - 150)

        }
        self.currentScene?.addChild(manaBar)
        manaBar.zPosition = 1
    }
    
    func healthIncreased(notification:NSNotification) {
        
    }
    
    func healthDecreased(notification:NSNotification) {
        
    }
    
    func manaIncreased(notification:NSNotification) {
        
    }
    
    func manaDecreased(notification:NSNotification) {
        
    }
    
}
