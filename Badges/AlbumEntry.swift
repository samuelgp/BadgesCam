//
//  AlbumEntry.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/26/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation
import UIKit

class AlbumEntry {
    
    var task:UIImage
    var reward: UIImage
    
    init(task: UIImage, reward: UIImage) {
        self.task = task
        self.reward = reward
    }
}
