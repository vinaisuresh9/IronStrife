//
//  SceneTransitioning.swift
//  IronStrife
//
//  Created by Vinai Suresh on 3/15/18.
//  Copyright © 2018 Vinai Suresh. All rights reserved.
//

import Foundation
import SpriteKit

private struct AnimationTime {
    static let time: TimeInterval = 1
}

protocol SceneTransitioning {
    var upScene: GameScene? { get set }
    var downScene: GameScene? { get set }
    var rightScene: GameScene? { get set }
    var leftScene: GameScene? { get set }
}

extension SceneTransitioning where Self: SKScene {
    //MARK: Transitioning Scenes
    func transitionUp (_ newScene: GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.down, duration: AnimationTime.time)
        self.view?.presentScene(newScene, transition: transition)
    }

    func transitionRight (_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.left, duration: AnimationTime.time)
        self.view?.presentScene(newScene, transition: transition)

    }

    func transitionLeft (_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.right, duration: AnimationTime.time)
        self.view?.presentScene(newScene, transition: transition)
    }

    func transitionDown(_ newScene:GameScene) {
        let transition = SKTransition.push(with: SKTransitionDirection.up, duration: AnimationTime.time)
        self.view?.presentScene(newScene, transition: transition)
    }
}
