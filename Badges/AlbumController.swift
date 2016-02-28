//
//  AlbumController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/26/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class AlbumController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    

    let albumEntries = [
        AlbumEntry(task: UIImage(named: "task")!, reward: UIImage(named: "reward")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumEntries.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let albumEntry = albumEntries[indexPath.row]
        let cell = albumCollectionView.dequeueReusableCellWithReuseIdentifier("albumCell", forIndexPath: indexPath) as! AlbumCell
        cell.taskImageView.image = albumEntry.task
        cell.rewardImageView.image = albumEntry.reward
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
