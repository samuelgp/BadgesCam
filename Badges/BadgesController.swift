//
//  BadgesController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/25/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class BadgesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var activeButton: UIButton!
    
    
    var badges = [Badge]()
    var pendingBadges = [Badge]()
    var completedBadges = [Badge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeButton.layer.borderWidth = 0.7
        completedButton.layer.borderWidth = 0.7
        
        setup()
        populateBadgeStatus()
        
        let lpGesture = UILongPressGestureRecognizer(target: self, action: "changeIcon:")
        lpGesture.minimumPressDuration = 0.5
        lpGesture.delaysTouchesBegan = true
        lpGesture.cancelsTouchesInView = true
        lpGesture.delegate = self
        collectionView.addGestureRecognizer(lpGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        populateBadgeStatus()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    private func addCheckpointsToBadge(badge: Badge, checkpoints: NSDictionary) {
        let checkpointTypes = ["active", "completed"];
        for type in checkpointTypes {
            for currentCheckpoint in checkpoints[type] as! NSArray {
                let checkpoint = currentCheckpoint as! NSDictionary
                let newCheckpoint = Checkpoint(title: checkpoint["title"] as! String, repetitions: (checkpoint["timesCompleted"] as! Int) + (checkpoint["timesRemaining"] as! Int))
                
                for image in checkpoint["imageUrls"] as! NSArray {
                    newCheckpoint.addImage(UIImage(named: image as! String)!)
                }
                badge.addCheckpoint(newCheckpoint)
            }
        }
    }
    
    private func setup() {
        guard let path = NSBundle.mainBundle().pathForResource("sourceData", ofType: "json") else {
            print("Couldn't find the source file.")
            return
        }
        
        do {
            let data: NSData? = NSData(contentsOfFile: path)
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                let missions = json["missions"] as! NSDictionary
                let missionTypes = ["active", "completed"]
                for type in missionTypes {
                    for curMission in missions[type] as! NSArray {
                        let mission = curMission as! NSDictionary
                        let badge = Badge(name: mission["title"] as! String, image: UIImage(named: mission["badge"] as! String)!)
                        let checkpoints = mission["milestones"] as! NSDictionary
                        addCheckpointsToBadge(badge, checkpoints: checkpoints)
                        badges.append(badge)
                    }
                }
            }
        } catch let error as NSError {
            print("Error: \(error)")
            return
        } catch {
            print("error")
            return
        }
        
        
//        let dogBadge = Badge(name: "Get a Dog", image: UIImage(named: "paw")!)
//        
//        let dogBreedCheckpoint = Checkpoint(title: "Learn what breed of dog I want", repetitions: 1)
//        dogBreedCheckpoint.addImage(UIImage(named: "dog-4")!)
//        dogBadge.addCheckpoint(dogBreedCheckpoint)
//        
//        dogBadge.addCheckpoint(Checkpoint(title: "Learn what dogs can/can't eat", repetitions: 1))
//        
//        let walkDogCheckpoint = Checkpoint(title: "Walk Mr Jackson's dog", repetitions: 3)
//        walkDogCheckpoint.addImage(UIImage(named: "walking-dog")!)
//        dogBadge.addCheckpoint(walkDogCheckpoint)
//        badges.append(dogBadge)
//        
//        let helpOthersBadge = Badge(name: "Learn to Help Others", image: UIImage(named: "plane")!)
//        helpOthersBadge.addCheckpoint(Checkpoint(title: "Do something nice for someone", repetitions: 2))
//        badges.append(helpOthersBadge)
//        
//        let teachMeSomethingBadge = Badge(name: "Teach me something", image: UIImage(named: "kite")!)
//        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Select an interesting topic", repetitions: 1))
//        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Learn about it by searching the internet or asking your teacher", repetitions: 1))
//        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Teach mom or dad the topic", repetitions: 1))
//        badges.append(teachMeSomethingBadge)
//        
//        let learnNewLanguageBadge = Badge(name: "Learn a new Language", image: UIImage(named: "key")!)
//        learnNewLanguageBadge.addCheckpoint(Checkpoint(title: "Pick a language", repetitions: 1))
//        badges.append(learnNewLanguageBadge)
//        
//        let soccerBadge = Badge(name: "Learn to play Soccer", image: UIImage(named: "flag")!)
//        let getBallCheckpoint = Checkpoint(title: "Get a soccer ball", repetitions: 1)
//        getBallCheckpoint.addImage(UIImage(named: "getBall")!)
//        soccerBadge.addCheckpoint(getBallCheckpoint)
//        
//        let chaseBallCheckpoint = Checkpoint(title: "Run after the ball", repetitions: 1)
//        chaseBallCheckpoint.addImage(UIImage(named: "chaseBall")!)
//        soccerBadge.addCheckpoint(chaseBallCheckpoint)
//        
//        let playWithOthersCheckpoint = Checkpoint(title: "Play with others", repetitions: 1)
//        playWithOthersCheckpoint.addImage(UIImage(named: "playWithOthers")!)
//        soccerBadge.addCheckpoint(playWithOthersCheckpoint)
//        badges.append(soccerBadge)
//        
//        let cookPastaCheckpoint = Checkpoint(title: "Cook Pasta", repetitions: 1)
//        cookPastaCheckpoint.addImage(UIImage(named: "cookPasta")!)
//        let learnToCookPastaBadge = Badge(name: "Learn to cook Pasta", image: UIImage(named: "anchor")!)
//        learnToCookPastaBadge.addCheckpoint(cookPastaCheckpoint)
//        badges.append(learnToCookPastaBadge)
//        
//        let playChessCheckpoint = Checkpoint(title: "Play Chess", repetitions: 1)
//        playChessCheckpoint.addImage(UIImage(named: "playChess")!)
//        let playChessBadge = Badge(name: "Learn to play Chess", image: UIImage(named: "rocket")!)
//        playChessBadge.addCheckpoint(playChessCheckpoint)
//        badges.append(playChessBadge)
//        
//        let danceCheckpoint = Checkpoint(title: "Dance", repetitions: 1)
//        danceCheckpoint.addImage(UIImage(named: "dance")!)
//        let danceBadge = Badge(name: "Learn to Dance", image: UIImage(named: "silly")!)
//        danceBadge.addCheckpoint(danceCheckpoint)
//        badges.append(danceBadge)
//        
//        let instrumentCheckpoint = Checkpoint(title: "Play Instrument", repetitions: 1)
//        instrumentCheckpoint.addImage(UIImage(named: "instrument")!)
//        let instrumentBadge = Badge(name: "Learn to play an Instrument", image: UIImage(named: "feather")!)
//        instrumentBadge.addCheckpoint(instrumentCheckpoint)
//        badges.append(instrumentBadge)
//        
//        let makeBedCheckpoint = Checkpoint(title: "Make Bed", repetitions: 1)
//        makeBedCheckpoint.addImage(UIImage(named: "makeBed")!)
//        let makeBedBadge = Badge(name: "Learn to make your bed", image: UIImage(named: "key")!)
//        makeBedBadge.addCheckpoint(makeBedCheckpoint)
//        badges.append(makeBedBadge)
    }
    
    private func populateBadgeStatus() {
        pendingBadges.removeAll()
        completedBadges.removeAll()
        
        for badge in badges {
            if badge.isActive() {
                pendingBadges.append(badge)
            } else {
                completedBadges.append(badge)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pendingBadges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let badge = pendingBadges[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("badgeCell", forIndexPath: indexPath) as! BadgeCell
        cell.badgeLabel.text = badge.name
        cell.imageView.image = badge.image
        return cell
    }
    
    func changeIcon(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizerState.Began {
            return
        }
        
        let gestureLocation = gestureRecognizer.locationInView(collectionView)
        let indexPath = collectionView.indexPathForItemAtPoint(gestureLocation)
        
        if let index = indexPath {
            let cell = collectionView.cellForItemAtIndexPath(index) as! BadgeCell
            performSegueWithIdentifier("toSelectIcon", sender: cell)
        }
    }
       
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier{
            case "toCheckpoints":
                let indexPath = self.collectionView.indexPathForCell(sender as! BadgeCell)!
                let checkpointsVC = segue.destinationViewController as! CheckpointsController
                checkpointsVC.badge = pendingBadges[indexPath.row]
            case "toCompleted":
                populateBadgeStatus()
                let albumVC = segue.destinationViewController as! AlbumController
                albumVC.completedBadges = completedBadges
            case "toSelectIcon":
                let cell = sender as! BadgeCell
                let badge = badges[collectionView.indexPathForCell(cell)!.row]
                let iconsVC = segue.destinationViewController as! IconsController
                iconsVC.badge = badge
            default: break
            }
        }

    }

}
