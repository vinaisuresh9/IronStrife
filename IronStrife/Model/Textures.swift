//
//  Textures.swift
//  IronStrife
//
//  Created by Vinai Suresh on 12/27/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

class Textures {
    
    static let allTextureAtlases = [Textures.goreblonTextures, Textures.meeblonTextures, Textures.skelatonTextures, Textures.playerTextures, Textures.icespellTextures, Textures.curespellTextures, Textures.explosionTextures]
    
    static let allTextures = [Textures.fireballTexture]

    //MARK: Texture Atlases
    static let goreblonTextures = SKTextureAtlas(named: "Goreblon")
    
    static let meeblonTextures = SKTextureAtlas(named: "Meeblon")
    
    static let skelatonTextures = SKTextureAtlas(named: "Skelaton")
    
    static let playerTextures = SKTextureAtlas(named: "Player")
    
    static let icespellTextures = SKTextureAtlas(named: "IceCircle")
    
    static let curespellTextures = SKTextureAtlas(named: "Cure")
    
    static let explosionTextures = SKTextureAtlas(named: "FireExplosion")
    
    //MARK: Textures
    
    static let fireballTexture = SKTexture(imageNamed: "firemagic.png")
    
}
