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
    static let time: TimeInterval = 0.5
}

protocol SceneTransitioning {
    var upScene: GameScene? { get }
    var downScene: GameScene? { get }
    var rightScene: GameScene? { get }
    var leftScene: GameScene? { get }
}

extension SceneTransitioning where Self: SKScene {

    func transitionScene(direction: SKTransitionDirection, startPoint: CGPoint) {
        var transitionedScene: GameScene?
        switch direction {
        case .up:
            transitionedScene = upScene
        case .down:
            transitionedScene = downScene
        case .left:
            transitionedScene = leftScene
        case .right:
            transitionedScene = rightScene
        }

        guard let newScene = transitionedScene else { return }

        PlayerOverviewManager.sharedInstance.currentScene = newScene
        newScene.startPoint = startPoint

        let transitionDirection = direction.invert()
        let transition = SKTransition.push(with: transitionDirection, duration: AnimationTime.time)
        self.view?.presentScene(newScene, transition: transition)

    }
}
