//
//  CheckpointsController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 3/3/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit
import MobileCoreServices

class CheckpointsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var badge: Badge?
    var checkpoints = [Checkpoint]()
    
    @IBOutlet weak var pendingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = badge?.name
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor()]
        pendingTableView.dataSource = self
        pendingTableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        populateCheckpoints()
        pendingTableView.reloadData()
    }
    
    private func populateCheckpoints() {
        checkpoints.removeAll()
        var completedCheckpoints = [Checkpoint]()
        for checkpoint in (badge?.checkpoints)! {
            if checkpoint.isComplete() {
                completedCheckpoints.append(checkpoint)
            } else {
                checkpoints.append(checkpoint)
            }
        }
        checkpoints.appendContentsOf(completedCheckpoints)
    }
    
    // TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkpoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let checkpoint = checkpoints[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("pendingCheckpointCell", forIndexPath: indexPath) as! PendingCheckPointCell
        cell.checkPoint = checkpoint
        
        if !checkpoint.isComplete() {
            cell.titleLabel.text = "\(checkpoint.title) x \(checkpoint.repetitions)"
        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: checkpoint.title)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.titleLabel.attributedText = attributeString
            cell.cameraImage.hidden = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PendingCheckPointCell else { return }
        tableViewCell.setCollectionViewDataSourceAndDelegate(self, forRow: indexPath.row)
    }
    
    var lastSelectedIndex: Int?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        lastSelectedIndex = indexPath.row
        if !checkpoints[indexPath.row].isComplete() {
            invokeCamera()
        }
    }
    
    // CollectionView Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkpoints[collectionView.tag].repetitions
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("checkpointCollectionCell", forIndexPath: indexPath) as! CheckpointCollectionCell
        if indexPath.row > checkpoints[collectionView.tag].images.count - 1 {
            cell.imageView.image = UIImage(named: "grey-background")
        } else {
            cell.imageView.image = checkpoints[collectionView.tag].images[indexPath.row]
        }
        cell.layer.cornerRadius = cell.frame.size.width/2
        return cell
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
    
    // ImagePicker Methods
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let takenImage = (info[UIImagePickerControllerEditedImage] ?? info[UIImagePickerControllerOriginalImage]) as? UIImage
        if let lastSelectedIndex = lastSelectedIndex {
            let checkpoint = checkpoints[lastSelectedIndex]
            if checkpoint.images.count < checkpoint.repetitions {
                checkpoint.addImage(takenImage!)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        populateCheckpoints()
        pendingTableView.reloadData()
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
