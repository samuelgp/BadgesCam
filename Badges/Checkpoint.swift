//
//  Checkpoint.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 3/3/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation
import UIKit

class Checkpoint {
    
    var title: String
    var repetitions: Int
    var images = [UIImage]()
    
    init(title: String, repetitions: Int) {
        self.title = title
        self.repetitions = repetitions
    }
    
    func addImage(image: UIImage) {
        if images.count < repetitions {
            images.append(image)
        }
    }
    
    func isComplete() ->Bool {
        return repetitions == images.count
    }
    
}
