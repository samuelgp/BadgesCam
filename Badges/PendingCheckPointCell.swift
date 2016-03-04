//
//  PendingCheckPointCell.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 3/3/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class PendingCheckPointCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var checkPoint: Checkpoint?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (checkPoint?.repetitions)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("checkpointCollectionCell", forIndexPath: indexPath) as! CheckpointCollectionCell
        if (indexPath.row > ((checkPoint?.images.count)! - 1)) {
            cell.imageView.image = UIImage(named: "grey-background")
        } else {
            cell.imageView.image = checkPoint?.images[indexPath.row]
        }
        cell.layer.cornerRadius = cell.frame.size.width/2
        return cell
    }

}
