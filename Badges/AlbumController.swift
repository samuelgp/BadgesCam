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
    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    

    var completedBadges = [Badge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        activeButton.layer.borderWidth = 0.7
        completedButton.layer.borderWidth = 0.7
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return completedBadges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let badge = completedBadges[indexPath.row]
        let cell = albumCollectionView.dequeueReusableCellWithReuseIdentifier("albumCell", forIndexPath: indexPath) as! AlbumCell
        cell.taskImageView.image = badge.image
        cell.titleLabel.text = badge.name
        return cell
    }
    
    @IBAction func activeButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    private func getAllImages(badge: Badge) ->[UIImage] {
        var result = [UIImage]()
        for checkPoint in badge.checkpoints {
            for image in checkPoint.images {
                result.append(image)
            }
        }
        return result
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = albumCollectionView.indexPathForCell(sender as! AlbumCell)!
        let images = getAllImages(completedBadges[indexPath.row])
        let albumImagesVC = segue.destinationViewController as! AlbumImagesController
        albumImagesVC.images = images
        albumImagesVC.badgeTitle = completedBadges[indexPath.row].name
    }

}
