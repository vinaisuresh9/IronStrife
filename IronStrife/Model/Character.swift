//
//  Character.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/26/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit


enum CollisionBitMask: UInt32 {
    case
    player              = 1,
    playerProjectile    = 2,
    enemyProjectile     = 4,
    enemy               = 8,
    other               = 16,
    spell               = 32,
    wall                = 64
    
}

enum Direction: String {
    case Left = "Left",
    Right = "Right",
    Down = "Down",
    Up = "Up"
}


///Base class for all Characters in game. Many methods need to be overridden
class Character: SKSpriteNode {
    var health: Float = 0.0
    var mana: Float = 0.0
    
    var attackStrength: Float = 0.0
    var defense: Float = 0.0
    
    var isDying: Bool = false
    var isAttacking: Bool = false
    var isHit: Bool = false
    
    ///Variable that determines how much to to slow down velocity
    var slowFactor: Float = 1
    var movespeed: Float = 250
    var effectiveMovespeed: CGFloat {
        get {
            return CGFloat(movespeed * slowFactor)
        }
    }
    
    let animationAttackSpeed = 0.05
    let animationMovementSpeed = 0.1
    
    var destination: CGPoint? = CGPoint(x: 0, y: 0)

    var currentMovementAnimationKey = ""
    var activeAnimationKey = ""
    var direction = Direction.Down
    
    var attackSoundPrefix = ""
    var numberAttackSounds: UInt32 = 0
    
    let shadowNode = SKSpriteNode(imageNamed: "Shadow.png")
    
    //MARK: Texture Arrays
    var downMovementTextures: [SKTexture] = []
    var upMovementTextures: [SKTexture] = []
    var leftMovementTextures: [SKTexture] = []
    var rightMovementTextures: [SKTexture] = []
    
    var currentMovementTextures: [SKTexture] = []

    var upAttackTextures: [SKTexture] = []
    var downAttackTextures: [SKTexture] = []
    var leftAttackTextures: [SKTexture] = []
    var rightAttackTextures: [SKTexture] = []
    
    var getHitAnimationFrames: [SKTexture] = []
    var deathAnimationFrames: [SKTexture] = []
    
    
    //MARK: Initialization
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        zPosition = WorldLayer.character
        
        addChild(shadowNode)
        shadowNode.zPosition = WorldLayer.shadow
        shadowNode.setScale(0.8)
        shadowNode.position = CGPoint(x: 0, y: -frame.size.height * 0.6)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initializeTextureArrays(){
        
    }
    
    override func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){
        if (action(forKey: currentMovementAnimationKey) != nil){
            checkDestination()
        }
        
        shadowNode.position = CGPoint(x: 0, y: -frame.size.height * 0.6)
    }
    
    func configureStats() {
        
    }
    
    func preloadSounds() {
        guard numberAttackSounds > 0 else { return }
        for i in 1...numberAttackSounds {
            let soundFile = "\(attackSoundPrefix)\(i).wav"
            SKAction.playSoundFileNamed(soundFile, waitForCompletion: false)
        }
    }
    
    
    //MARK: Physics Bodies (Overridden)
    
    func collidedWith (_ other: SKPhysicsBody){

    }
    
    //MARK: Applying Damage
    //TODO: Figure out pushback animations and how damage is applied
    func applyDamage(_ damage: Float) -> Bool{
        health -= (damage - defense)
        
        if (health <= 0){
            performDeath()
            return true
        }
        
        return false
    }
    
    //MARK: Dying (Overriden)
    func performDeath(){
        health = 0.0
        isDying = true

    }
    
    
    //MARK: Attacking 
    func meleeAttack(_ direction: Direction){
        if (isAttacking){
            return
        }
        stopMoving()
        isAttacking = true
        
        var attackAnimation: SKAction
        switch (direction){
            
        case .Up:
            self.direction = .Up
            attackAnimation = SKAction.animate(with: upAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case .Down:
            self.direction = .Down
            attackAnimation = SKAction.animate(with: downAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case .Right:
            self.direction = .Right
            attackAnimation = SKAction.animate(with: rightAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        case .Left:
            self.direction = .Left
            attackAnimation = SKAction.animate(with: leftAttackTextures, timePerFrame: animationAttackSpeed, resize: true, restore: false)
            
        }
        
        let soundFile = "\(attackSoundPrefix)\((arc4random() % numberAttackSounds) + 1).wav"
        let sound = SKAction.playSoundFileNamed(soundFile, waitForCompletion: false)
        
        run(SKAction.group([sound,attackAnimation]), completion: {
            self.isAttacking = false
        })
    }
    
    //MARK: Movement and Orientation
    func moveTo(_ point:CGPoint)
    {
        //var movementAction = SKAction.moveTo(scenePoint, duration: time)
        //player.runAction(movementAction, withKey: player.direction)
        
        destination = point
        
        let dir = directionToPoint(point)
        if (dir != direction || action(forKey: currentMovementAnimationKey) == nil) {
            setDirection(dir)
            animateMovementInDirection(dir)
        }
        
        let velocityVector = MathFunctions.normalizedVector(position, point2: point)
        
        physicsBody?.velocity = CGVector(dx: velocityVector.dx * effectiveMovespeed , dy: velocityVector.dy * effectiveMovespeed)
    }
    
    func animateMovementInDirection(_ dir: Direction) {
        removeAction(forKey: currentMovementAnimationKey)
        currentMovementAnimationKey = direction.rawValue
        let animateAction = SKAction.animate(with: currentMovementTextures, timePerFrame: animationMovementSpeed, resize: true, restore: false)
        run(SKAction.repeatForever(animateAction), withKey: currentMovementAnimationKey)
    }
    
    
    func reachedDestination() -> Bool{
        if let destination = destination, MathFunctions.calculateDistance(position, point2: destination) < 10 {
            self.destination = nil
            return true;
        }
        return false;
    }
    
    
    func checkDestination(){
        if (reachedDestination()){
            stopMoving()
            removeAllActions()
        }
    }
    
    
    func setDirection(_ direction: Direction) {
        
        let atlas = SKTextureAtlas(named: theClassName)
        
        texture = atlas.textureNamed(direction.rawValue + "1")
        switch (direction) {
            case .Up:
                self.direction = .Up
                currentMovementTextures = upMovementTextures
            
            case .Down:
                self.direction = .Down
                currentMovementTextures = downMovementTextures

            case .Right:
                self.direction = .Right
                currentMovementTextures = rightMovementTextures
                
            case .Left:
                self.direction = .Left
                currentMovementTextures = leftMovementTextures
            
        }
    }
    
    
    func directionToPoint(_ point: CGPoint) -> Direction {
        let vector = MathFunctions.normalizedVector(position, point2: point)
        let angle = asinf(Float(vector.dy)/Float(1))
        
        switch (angle) {
            case _ where angle >= Float(M_PI_4) && angle <= (3 * Float(M_PI_4)):
                return Direction.Up
            
            case _ where angle <= Float(M_PI_4) && angle >= -Float(M_PI_4) && (point.x <= position.x):
                return Direction.Left
            
            case _ where angle <= -Float(M_PI_4) && angle >= -(3 * Float(M_PI_4)):
                return Direction.Down

            default:
                return Direction.Right
        }
    }
    
    
    func stopMoving(){
        physicsBody?.velocity = CGVector.zero
        removeAction(forKey: currentMovementAnimationKey)
        currentMovementAnimationKey = ""
        destination = position
        
    }

}
