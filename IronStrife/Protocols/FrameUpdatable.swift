//
//  FrameUpdatable.swift
//  IronStrife
//
//  Created by Vinai on 7/16/18.
//  Copyright © 2018 Vinai Suresh. All rights reserved.
//

import Foundation
import SpriteKit

protocol FrameUpdatable {
    func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval)
}

protocol ChildFrameUpdating: FrameUpdatable {
    var updateableChildren: [SKNode & FrameUpdatable] { get }
}

extension ChildFrameUpdating {
    func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval) {
        for child in updateableChildren {
            child.updateWithTimeSinceLastUpdate(timeSince)
        }
    }
}
