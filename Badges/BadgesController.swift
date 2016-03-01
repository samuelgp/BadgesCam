//
//  BadgesController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/25/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit
import MobileCoreServices

class BadgesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let badges = [
        Badge(name: "Set the Table", image: UIImage(named: "setTable")!),
        Badge(name: "Put away Toys", image: UIImage(named: "putAwayToys")!),
        Badge(name: "Help cook Dinner", image: UIImage(named: "cookDinner")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let badge = badges[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeCell
        cell.badgeLabel.text = badge.name
        cell.imageView.image = badge.image
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        invokeCamera()
//        self.performSegueWithIdentifier("toCamera", sender: self)
    }
    
    // Camera
    
    func invokeCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .Camera
            picker.mediaTypes = [kUTTypeImage as String]
            picker.allowsEditing = true
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let takenImage = (info[UIImagePickerControllerEditedImage] ?? info[UIImagePickerControllerOriginalImage]) as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
        let alert = AlertUtils.getMessageAlert("Badge Accepted.", message: "Cool! Your badge was accepted. Great job!")
        self.presentViewController(alert, animated: true, completion: nil)
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
