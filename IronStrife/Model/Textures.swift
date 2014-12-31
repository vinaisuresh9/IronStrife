//
//  Textures.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/27/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Textures {
    

    //This would be a class variable when supported
    private struct goreblon { static let goreblon = SKTextureAtlas(named: "Goreblon") }
    internal class var goreblonTextures: SKTextureAtlas{
        get{ return goreblon.goreblon}
    }
    
    private struct player { static let player = SKTextureAtlas(named: "Player")}
    internal class var playerTextures: SKTextureAtlas{
        get { return player.player}
    }
    
    private struct fireball { static let fireball = SKTexture(imageNamed: "firemagic")}
    internal class var fireballTexture: SKTexture{
        get { return fireball.fireball}
    }
    
}
