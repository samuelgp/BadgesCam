//
//  PendingCheckPointCell.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 3/3/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class PendingCheckPointCell: UITableViewCell {
    
    var checkPoint: Checkpoint?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceAndDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }

}
