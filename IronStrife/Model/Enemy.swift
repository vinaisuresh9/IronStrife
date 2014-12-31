//
//  Enemy.swift
//  IronStrife
//
//  Created by Vinai Suresh on 9/7/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import SpriteKit

enum AttackType{
    case Melee,
    Range
}

class Enemy: Character {
    var type: AttackType = AttackType.Melee
}
