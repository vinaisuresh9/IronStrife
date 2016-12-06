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
    
    static let sharedInstance = PlayerOverviewManager()
    
    var currentScene: GameScene? {
        didSet {
            self.configureOverlay()
        }
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(healthDecreased), name: NSNotification.Name(rawValue: playerHealthDecreasedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(healthIncreased), name: NSNotification.Name(rawValue: playerHealthIncreasedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(manaDecreased), name: NSNotification.Name(rawValue: playerManaDecreasedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(manaIncreased), name: NSNotification.Name(rawValue: playerManaIncreasedNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func configureOverlay() {
        _ = SKShapeNode()
        //border.path = UIBezierPath.
        
        let healthBar = SKSpriteNode(imageNamed: "HealthBar.png")
        healthBar.setScale(0.6)
        healthBar.colorBlendFactor = 1
        healthBar.color = UIColor.green
        if let height = self.currentScene?.frame.size.height {
            healthBar.position = CGPoint(x: 150, y: height - 150)
        }
        self.currentScene?.addChild(healthBar)
        healthBar.zPosition = 1
        
        
        let manaBar = SKSpriteNode(imageNamed: "HealthBar.png")
        manaBar.setScale(0.6)
        manaBar.colorBlendFactor = 1
        manaBar.color = UIColor.blue
        if let width = self.currentScene?.frame.size.width,
            let height = self.currentScene?.frame.size.height {
            manaBar.position = CGPoint(x: width - 150, y: height - 150)

        }
        self.currentScene?.addChild(manaBar)
        manaBar.zPosition = 1
    }
    
    func healthIncreased(_ notification:Notification) {
        
    }
    
    func healthDecreased(_ notification:Notification) {
        
    }
    
    func manaIncreased(_ notification:Notification) {
        
    }
    
    func manaDecreased(_ notification:Notification) {
        
    }
    
}
