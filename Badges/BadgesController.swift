//
//  BadgesController.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/25/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class BadgesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate {
    
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
    
    private func setup() {
        let dogBadge = Badge(name: "Get a Dog", image: UIImage(named: "fs-trophy")!)
        
        let dogBreedCheckpoint = Checkpoint(title: "Learn what breed of dog I want", repetitions: 1)
        dogBreedCheckpoint.addImage(UIImage(named: "dog-4")!)
        dogBadge.addCheckpoint(dogBreedCheckpoint)
        
        dogBadge.addCheckpoint(Checkpoint(title: "Learn what dogs can/can't eat", repetitions: 1))
        
        let walkDogCheckpoint = Checkpoint(title: "Walk Mr Jackson's dog", repetitions: 3)
        walkDogCheckpoint.addImage(UIImage(named: "walking-dog")!)
        dogBadge.addCheckpoint(walkDogCheckpoint)
        badges.append(dogBadge)
        
        let helpOthersBadge = Badge(name: "Learn to Help Others", image: UIImage(named: "fs-paper-plane")!)
        helpOthersBadge.addCheckpoint(Checkpoint(title: "Do something nice for someone", repetitions: 2))
        badges.append(helpOthersBadge)
        
        let teachMeSomethingBadge = Badge(name: "Teach me something", image: UIImage(named: "fs-compass")!)
        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Select an interesting topic", repetitions: 1))
        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Learn about it by searching the internet or asking your teacher", repetitions: 1))
        teachMeSomethingBadge.addCheckpoint(Checkpoint(title: "Teach mom or dad the topic", repetitions: 1))
        badges.append(teachMeSomethingBadge)
        
        let learnNewLanguageBadge = Badge(name: "Learn a new Language", image: UIImage(named: "fs-key")!)
        learnNewLanguageBadge.addCheckpoint(Checkpoint(title: "Pick a language", repetitions: 1))
        badges.append(learnNewLanguageBadge)
        
        let soccerBadge = Badge(name: "Learn to play Soccer", image: UIImage(named: "fs-flag")!)
        let getBallCheckpoint = Checkpoint(title: "Get a soccer ball", repetitions: 1)
        getBallCheckpoint.addImage(UIImage(named: "getBall")!)
        soccerBadge.addCheckpoint(getBallCheckpoint)
        
        let chaseBallCheckpoint = Checkpoint(title: "Run after the ball", repetitions: 1)
        chaseBallCheckpoint.addImage(UIImage(named: "chaseBall")!)
        soccerBadge.addCheckpoint(chaseBallCheckpoint)
        
        let playWithOthersCheckpoint = Checkpoint(title: "Play with others", repetitions: 1)
        playWithOthersCheckpoint.addImage(UIImage(named: "playWithOthers")!)
        soccerBadge.addCheckpoint(playWithOthersCheckpoint)
        badges.append(soccerBadge)
        
        let cookPastaCheckpoint = Checkpoint(title: "Cook Pasta", repetitions: 1)
        cookPastaCheckpoint.addImage(UIImage(named: "cookPasta")!)
        let learnToCookPastaBadge = Badge(name: "Learn to cook Pasta", image: UIImage(named: "fs-anchor")!)
        learnToCookPastaBadge.addCheckpoint(cookPastaCheckpoint)
        badges.append(learnToCookPastaBadge)
        
        let playChessCheckpoint = Checkpoint(title: "Play Chess", repetitions: 1)
        playChessCheckpoint.addImage(UIImage(named: "playChess")!)
        let playChessBadge = Badge(name: "Learn to play Chess", image: UIImage(named: "fs-rocket")!)
        playChessBadge.addCheckpoint(playChessCheckpoint)
        badges.append(playChessBadge)
        
        let danceCheckpoint = Checkpoint(title: "Dance", repetitions: 1)
        danceCheckpoint.addImage(UIImage(named: "dance")!)
        let danceBadge = Badge(name: "Learn to Dance", image: UIImage(named: "fs-bug")!)
        danceBadge.addCheckpoint(danceCheckpoint)
        badges.append(danceBadge)
        
        let instrumentCheckpoint = Checkpoint(title: "Play Instrument", repetitions: 1)
        instrumentCheckpoint.addImage(UIImage(named: "instrument")!)
        let instrumentBadge = Badge(name: "Learn to play an Instrument", image: UIImage(named: "fs-bicycle")!)
        instrumentBadge.addCheckpoint(instrumentCheckpoint)
        badges.append(instrumentBadge)
        
        let makeBedCheckpoint = Checkpoint(title: "Make Bed", repetitions: 1)
        makeBedCheckpoint.addImage(UIImage(named: "makeBed")!)
        let makeBedBadge = Badge(name: "Learn to make your bed", image: UIImage(named: "fs-space")!)
        makeBedBadge.addCheckpoint(makeBedCheckpoint)
        badges.append(makeBedBadge)
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
            default: break
            }
        }

    }

}
