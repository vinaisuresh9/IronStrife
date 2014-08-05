//
//  Fireball.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/19/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import UIKit
import SpriteKit

var fireballMoveSpeed = Double(400)

class Fireball: SKSpriteNode {
    //This would be a class variable
    //var moveSpeed: Double = Double(400)
    var direction = CGVectorMake(0, 0)
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
    
    convenience init(direction: CGVector){
        self.init()
        self.direction = direction
        
    }
    ///Initializes default firemagic icon
    convenience override init(){
        self.init(imageNamed: "firemagic")
        self.setScale(0.8)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
}
