//
//  SKTransitionDirectionExtension.swift
//  IronStrife
//
//  Created by Vinai on 7/21/18.
//  Copyright © 2018 Vinai Suresh. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTransitionDirection {

    func invert() -> SKTransitionDirection {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}
