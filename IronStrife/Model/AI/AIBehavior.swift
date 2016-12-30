//
//  AIBehavior.swift
//  IronStrife
//
//  Created by Vinai Suresh on 4/4/15.
//  Copyright (c) 2015 Vinai Suresh. All rights reserved.
//

protocol AIBehavior {
    func run(_ ai: AI)
    
    static func checkPreconditions(_ ai: AI) -> Bool
    
}
