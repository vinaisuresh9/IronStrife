//
//  AIBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/4/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

protocol AIBehavior {
    var player: Player {get}
    func run(enemy: Enemy)
    
    static func checkPreconditions(enemy: Enemy) -> Bool
    
}