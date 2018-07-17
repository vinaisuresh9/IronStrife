//
//  Room1Scene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 5/25/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Room1Scene: GameScene, SceneTransitioning {

    // MARK: - SceneTransitioning
    var leftScene: GameScene?
    var rightScene: GameScene?
    var upScene: GameScene?
    var downScene: GameScene?
    
    override func didMove(to view: SKView) {
        super.setupScene()
        
        rightScene = TownScene.unarchiveFromFile() as! TownScene
        rightScene?.scaleMode = SKSceneScaleMode.fill
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
