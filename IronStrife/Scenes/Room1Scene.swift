//
//  Room1Scene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 5/25/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Room1Scene: GameScene {

    override func sceneDidLoad() {
        super.sceneDidLoad()

        super.setupScene()
    }

    override var rightScene: GameScene? {
        let scene = SceneManager.sharedInstance.scene(TownScene.self)
        scene?.scaleMode = .aspectFill
        return scene
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
