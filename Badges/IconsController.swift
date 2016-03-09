//
//  IconsController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 3/7/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class IconsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var badge: Badge?
    var icons = [
        UIImage(named: "anchor"),
        UIImage(named: "balloon"),
        UIImage(named: "bolt"),
        UIImage(named: "feather"),
        UIImage(named: "flag"),
        UIImage(named: "key"),
        UIImage(named: "kite"),
        UIImage(named: "paw"),
        UIImage(named: "plane"),
        UIImage(named: "mountain"),
        UIImage(named: "silly"),
        UIImage(named: "rocket")
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select an Icon for your Badge"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let icon = icons[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("iconCell", forIndexPath: indexPath) as! IconCollectionCell
        cell.imageView.image = icon
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        badge?.image = icons[indexPath.row]!
        navigationController?.popViewControllerAnimated(true)
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
