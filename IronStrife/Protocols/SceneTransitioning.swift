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
