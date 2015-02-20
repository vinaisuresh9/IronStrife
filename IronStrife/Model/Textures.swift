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
    
    private struct meeblon { static let meeblon = SKTextureAtlas(named: "Meeblon") }
    internal class var meeblonTextures: SKTextureAtlas{
        get{ return meeblon.meeblon}
    }
    
    private struct skelaton { static let skelaton = SKTextureAtlas(named: "Skelaton") }
    internal class var skelatonTextures: SKTextureAtlas{
        get{ return skelaton.skelaton}
    }
    
    private struct player { static let player = SKTextureAtlas(named: "Player")}
    internal class var playerTextures: SKTextureAtlas{
        get { return player.player}
    }
    
    private struct fireball { static let fireball = SKTexture(imageNamed: "firemagic")}
    internal class var fireballTexture: SKTexture{
        get { return fireball.fireball}
    }
    
    private struct icespell { static let icespell = SKTextureAtlas(named: "IceCircle")}
    internal class var iceSpellTextures: SKTextureAtlas{
        get { return icespell.icespell}
    }
    
    private struct cure { static let curespell = SKTextureAtlas(named: "Cure")}
    internal class var cureSpellTextures: SKTextureAtlas{
        get { return cure.curespell}
    }
    
    private struct explosion { static let explosion = SKTextureAtlas(named: "FireExplosion")}
    internal class var explosionTextures: SKTextureAtlas{
        get { return explosion.explosion}
    }
    
}
