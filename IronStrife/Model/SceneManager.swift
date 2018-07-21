//
//  SceneManager.swift
//  IronStrife
//
//  Created by Vinai on 7/21/18.
//  Copyright © 2018 Vinai Suresh. All rights reserved.
//

import Foundation

final class SceneManager {

    static let sharedInstance = SceneManager()

    private var sceneCache: [Int : GameScene] = [:]

    func scene<SceneType: GameScene>(_ sceneType: SceneType.Type) -> SceneType? {
        let scene = sceneCache[sceneType.hash()] ?? sceneType.unarchiveFromFile()
        if let unwrappedScene = scene as? GameScene {
            sceneCache[sceneType.hash()] = unwrappedScene
        }

        return scene as? SceneType
    }
}
