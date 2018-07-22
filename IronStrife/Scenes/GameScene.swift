//
//  GameScene.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/18/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//


//TODO: Will need to preload each level's textures into memory
//TODO: Might need to use a plist file for texture settings if needed later (and constant strings like downMovementAnimation).

import SpriteKit
import UIKit


struct WorldLayer {
    static let background: CGFloat = -1
    static let other: CGFloat = 0.2
    static let shadow: CGFloat = 0.3
    static let projectile: CGFloat = 0.4
    static let character: CGFloat = 0.5
}

class GameScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate, SceneTransitioning {

    private struct Identifiers {
        static let edgeConstant: CGFloat = 10
    }

    var lastUpdateTimeInterval: TimeInterval = 0
    let player = Player.sharedInstance
    var currentMovementAnimationKey = ""
    var startPoint: CGPoint = .zero

    // MARK: - SceneTransitioning
    private(set) var leftScene: GameScene?
    private(set) var rightScene: GameScene?
    private(set) var upScene: GameScene?
    private(set) var downScene: GameScene?

    // MARK: - SKScene

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        initializeGestureRecognizers()

        player.removeFromParent()
        addChild(player)
        player.position = startPoint
        player.stopMoving()
    }

    override func willMove(from view: SKView) {
        super.willMove(from: view)

        leftScene = nil
        rightScene = nil
        upScene = nil
        downScene = nil
    }

    // MARK: - Setup
        
    func setupScene()
    {
        //Do some initial setup
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        createEdges()

        let background = SKSpriteNode(imageNamed: "Background.png")
        background.size = self.frame.size
        background.zPosition = WorldLayer.background
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        addChild(background)
    }
    
    func createEdges() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: Identifiers.edgeConstant, y: Identifiers.edgeConstant, width: frame.width - (Identifiers.edgeConstant * 2), height: frame.height - (Identifiers.edgeConstant * 2)))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CollisionBitMask.wall.rawValue
        self.physicsBody?.collisionBitMask = CollisionBitMask.enemy.rawValue
        self.physicsBody?.contactTestBitMask = CollisionBitMask.player.rawValue
    }

    // MARK: - Gestures
    
    func initializeGestureRecognizers(){
        DispatchQueue.main.async {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameScene.tapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            self.view?.addGestureRecognizer(tapGesture)

            let twoFingerTapGesture = UITapGestureRecognizer(target: self, action: #selector(GameScene.twoFingerTap(_:)))
            twoFingerTapGesture.numberOfTouchesRequired = 2
            self.view?.addGestureRecognizer(twoFingerTapGesture)

            let twoFingerLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.twoFingerLongPress(_:)))
            twoFingerLongPressGesture.numberOfTouchesRequired = 2
            twoFingerLongPressGesture.minimumPressDuration = 0.1
            twoFingerLongPressGesture.allowableMovement = 5
            self.view?.addGestureRecognizer(twoFingerLongPressGesture)

            let movementGesture = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.longPress(_:)))
            movementGesture.minimumPressDuration = 0.3
            self.view?.addGestureRecognizer(movementGesture)

            let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
            upSwipeGesture.direction = UISwipeGestureRecognizerDirection.up
            self.view?.addGestureRecognizer(upSwipeGesture)

            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
            rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right
            self.view?.addGestureRecognizer(rightSwipeGesture)

            let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
            downSwipeGesture.direction = UISwipeGestureRecognizerDirection.down
            self.view?.addGestureRecognizer(downSwipeGesture)

            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(_:)))
            leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left
            self.view?.addGestureRecognizer(leftSwipeGesture)

            self.view?.showsPhysics = true
        }
    }
    
    @objc func swiped (_ sender: UISwipeGestureRecognizer){
        player.attackInDirection(sender.direction)
    }
    
    
    @objc func tapped (_ sender: UITapGestureRecognizer){
        let point = sender.location(in: self.view)
        player.castFireball(self.view!.convert(point, to: self))
    }
    
    
    @objc func twoFingerTap (_ sender: UITapGestureRecognizer) {
        player.castIceSpell()
    }
    
    
    @objc func twoFingerLongPress (_ sender: UILongPressGestureRecognizer){
        if (sender.state == UIGestureRecognizerState.began) {
            self.player.castCureSpell()
        }
    }
    
    
    @objc func longPress (_ sender: UILongPressGestureRecognizer){
        let point = sender.location(in: self.view)
        if let view = self.view {
            let scenePoint = view.convert(point, to: self)
            player.moveTo(position: scenePoint)
        }
    }

    // MARK: - SKPhysicsContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        //TODO: Can use contactNormal vector to decided pushback vector for gettingHit animation
        checkContact(contactPoint: contact.contactPoint, body1: contact.bodyA, body2: contact.bodyB)
        checkContact(contactPoint: contact.contactPoint, body1: contact.bodyB, body2: contact.bodyA)
    }

    // MARK: - Private

    private func checkContact(contactPoint: CGPoint, body1: SKPhysicsBody, body2: SKPhysicsBody) {
        switch (body1.node, body2.node) {
        case let (_ as Player, scene as GameScene):
            transition(withScene: scene, contact: contactPoint)
        case let (character as Character, _):
            character.collidedWith(body2)
        case let (fireball as Fireball, _):
            fireball.explode()
        default:
            break
        }
    }

    private func transition(withScene scene: SKScene, contact: CGPoint) {
        let frame = scene.frame

        switch (contact.x, contact.y) {
        case let (x, y) where x > frame.width - (Identifiers.edgeConstant + 5):
            let startPoint = CGPoint(x: (frame.width - x) + 50, y: y)
            transitionScene(direction: .right, startPoint: startPoint)
        case let (x, y) where x < Identifiers.edgeConstant + 5:
            let startPoint = CGPoint(x: (frame.width - x) - 50, y: y)
            transitionScene(direction: .left, startPoint: startPoint)
        case let (x, y) where y > frame.height - (Identifiers.edgeConstant + 5):
            let startPoint = CGPoint(x: x, y: (frame.height - y) + 50)
            transitionScene(direction: .up, startPoint: startPoint)
        case let (x, y) where y < Identifiers.edgeConstant + 5:
            let startPoint = CGPoint(x: x, y: (frame.height - y) - 50)
            transitionScene(direction: .down, startPoint: startPoint)
        default:
            break
        }
    }
    
    //MARK: - Update Loop
    override func update(_ currentTime: TimeInterval) {
        let timeSinceLast = currentTime - self.lastUpdateTimeInterval;
        self.lastUpdateTimeInterval = currentTime;
        self.updateWithTimeSinceLastUpdate(timeSinceLast)
    }
}

// MARK: - ChildFrameUpdating

extension GameScene: ChildFrameUpdating {
    var updateableChildren: [SKNode & FrameUpdatable] {
        return (children.filter{ $0 is Character } as? [SKNode & FrameUpdatable]) ?? []
    }
}
