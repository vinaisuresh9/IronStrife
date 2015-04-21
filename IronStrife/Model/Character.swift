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
    Player              = 1,
    PlayerProjectile    = 2,
    EnemyProjectile     = 4,
    Enemy               = 8,
    Other               = 16,
    Spell               = 32
    
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
            return CGFloat(self.movespeed * slowFactor)
        }
    }
    
    let animationAttackSpeed = 0.05
    let animationMovementSpeed = 0.1
    
    var destination: CGPoint = CGPointMake(0, 0)

    var currentMovementAnimationKey = ""
    var activeAnimationKey = ""
    var direction = Direction.Down
    
    var attackSoundPrefix = ""
    var numberAttackSounds:Int32 = 0
    
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
    
    func initializeTextureArrays(){
        
    }
    
    override func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){
        if (self.actionForKey(currentMovementAnimationKey) != nil){
            checkDestination()
        }
    }
    
    func configureStats() {
        
    }
    
    
    //MARK: Physics Bodies (Overridden)
    func configurePhysicsBody(){
        var center = CGPointZero
        center.y -= self.frame.height * 1/6
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width - 10, self.frame.height * 2/3), center: center)
        self.physicsBody?.mass = 0
        self.setScale(0.8)
        self.physicsBody!.allowsRotation = false;
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
    }
    
    func collidedWith (other: SKPhysicsBody){

    }
    
    //MARK: Applying Damage
    //TODO: Figure out pushback animations and how damage is applied
    func applyDamage(damage: Float) -> Bool{
        self.health -= (damage - self.defense)
        
        if (self.health <= 0){
            self.performDeath()
            return true
        }
        
        return false
    }
    
    //MARK: Dying (Overriden)
    func performDeath(){
        self.health = 0.0
        self.isDying = true

    }
    
    
    //MARK: Attacking 
    func meleeAttack(direction: Direction){
        if (self.isAttacking){
            return
        }
        self.stopMoving()
        self.isAttacking = true
        
        var attackAnimation: SKAction
        switch (direction){
            
        case .Up:
            self.direction = .Up
            attackAnimation = SKAction.animateWithTextures(upAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case .Down:
            self.direction = .Down
            attackAnimation = SKAction.animateWithTextures(downAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case .Right:
            self.direction = .Right
            attackAnimation = SKAction.animateWithTextures(rightAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        case .Left:
            self.direction = .Left
            attackAnimation = SKAction.animateWithTextures(leftAttackTextures, timePerFrame: self.animationAttackSpeed, resize: true, restore: false)
            
        default:
            break
            
        }
        
        let sound = SKAction.playSoundFileNamed(self.attackSoundPrefix + "\((rand() % self.numberAttackSounds) + 1).wav", waitForCompletion: false)
        
        self.runAction(SKAction.group([sound,attackAnimation]), completion: {
            self.isAttacking = false
        })
    }
    
    //MARK: Movement and Orientation
    func moveTo(point:CGPoint)
    {
        //var movementAction = SKAction.moveTo(scenePoint, duration: time)
        //player.runAction(movementAction, withKey: player.direction)
        
        self.destination = point
        
        let dir = self.directionToPoint(point)
        if (dir != self.direction || self.actionForKey(currentMovementAnimationKey) == nil) {
            self.setDirection(dir)
            self.animateMovementInDirection(dir)
        }
        
        var velocityVector = MathFunctions.normalizedVector(self.position, point2: point)
        
        self.physicsBody?.velocity = CGVectorMake(velocityVector.dx * self.effectiveMovespeed , velocityVector.dy * self.effectiveMovespeed)

    }
    
    func animateMovementInDirection(dir: Direction) {
        self.removeActionForKey(currentMovementAnimationKey)
        currentMovementAnimationKey = self.direction.rawValue
        let animateAction = SKAction.animateWithTextures(self.currentMovementTextures, timePerFrame: self.animationMovementSpeed, resize: true, restore: false)
        self.runAction(SKAction.repeatActionForever(animateAction), withKey: currentMovementAnimationKey)
    }
    
    
    func reachedDestination() -> Bool{
        if (MathFunctions.calculateDistance(self.position, point2: destination) < 10){
            return true;
        }
        return false;
    }
    
    
    func checkDestination(){
        if (self.reachedDestination()){
            self.stopMoving()
            self.removeAllActions()
        }
    }
    
    
    func setDirection(direction: Direction) {
        
        let atlas = SKTextureAtlas(named: self.theClassName)
        
        self.texture = atlas.textureNamed(direction.rawValue + "1")
        switch (direction) {
            case .Up:
                self.direction = .Up
                currentMovementTextures = self.upMovementTextures
            
            case .Down:
                self.direction = .Down
                currentMovementTextures = self.downMovementTextures

            case .Right:
                self.direction = .Right
                currentMovementTextures = self.rightMovementTextures
                
            case .Left:
                self.direction = .Left
                currentMovementTextures = self.leftMovementTextures
            
        }
    }
    
    
    func directionToPoint(point: CGPoint) -> Direction {
        let vector = MathFunctions.normalizedVector(self.position, point2: point)
        let angle = asinf(Float(vector.dy)/Float(1))
        
        switch (angle) {
            case let a where angle >= Float(M_PI_4) && angle <= (3 * Float(M_PI_4)):
                return Direction.Up
            
            case let a where angle <= Float(M_PI_4) && angle >= -Float(M_PI_4) && (point.x <= self.position.x):
                return Direction.Left
            
            case let a where angle <= -Float(M_PI_4) && angle >= -(3 * Float(M_PI_4)):
                return Direction.Down

            default:
                return Direction.Right
        }
    }
    
    
    func stopMoving(){
        self.physicsBody?.velocity = CGVector.zeroVector
        self.removeAllActions()
        self.destination = self.position
        
    }
    

}
