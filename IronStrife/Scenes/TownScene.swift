//
//  TownScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/29/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class TownScene: GameScene {

    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        startPoint = CGPoint(x:self.frame.midX, y:self.frame.midY)
        super.setupScene()

        let firstEnemy = Goreblon()
        firstEnemy.position = CGPoint(x: 40, y: self.frame.midY)
        addChild(firstEnemy)

        leftScene = SceneManager.sharedInstance.scene(Room1Scene.self)
        leftScene?.scaleMode = SKSceneScaleMode.aspectFill
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
