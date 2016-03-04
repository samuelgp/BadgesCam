//
//  Badge.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/25/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation
import UIKit

class Badge {
    
    var name: String
    var image: UIImage
    var checkpoints = [Checkpoint]()
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    func addCheckpoint(checkpoint: Checkpoint) {
        checkpoints.append(checkpoint)
    }
    
    func isActive() ->Bool {
        for checkpoint in checkpoints {
            if !checkpoint.isComplete() {
                return true
            }
        }
        return false
    }
}