//
//  TrackTableViewController.swift
//  F-Music
//
//  Created by Alex on 06/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//

import UIKit
import LoremSwiftum

class TrackTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved tracks.
        if let savedTracks = loadTracks() {
            tracks += savedTracks
        }
        
        else {
            // Else - load sample data.
            loadSampleTracks()
        }
    }
    
    /// Creating a random text (200 characters long) for the description box
    func someRandomText() -> String {
        /// Defining someLoremText (will use it in aboutTextView)
        var someLoremText = Lorem.sentences(3)
        // Set the <200 characters long description limit.
        repeat {
            someLoremText = Lorem.sentences(3)
        } while someLoremText.characters.count > 200
        return someLoremText
    }

    /// Loading sample data to the application
    func loadSampleTracks() {
        
        let randomText1 = someRandomText()
        let photo1 = UIImage(named: "Love_Metal")!
        let track1 = Track(name: "The Funeral of Hearts", artist: "HIM", photo: photo1, rating: 5, about: randomText1)!
        
        let randomText2 = someRandomText()
        let photo2 = UIImage(named: "RHCP")!
        let track2 = Track(name: "Californication", artist: "Red Hot Chili Pepper", photo: photo2, rating: 5, about: randomText2)!
        
        let randomText3 = someRandomText()
        let photo3 = UIImage(named: "Reamon")!
        let track3 = Track(name: "Faith", artist: "Reamon", photo: photo3, rating: 4, about: randomText3)!
        
        let randomText4 = someRandomText()
        let photo4 = UIImage(named: "Robbie Williams")!
        let track4 = Track(name: "Feel", artist: "Robbie Williams", photo: photo4, rating: 5, about: randomText4)!
        
        let randomText5 = someRandomText()
        let photo5 = UIImage(named: "Tarja Turunen")!
        let track5 = Track(name: "I walk alone", artist: "Tarja Turunen", photo: photo5, rating: 4, about: randomText5)!
        
        let randomText6 = someRandomText()
        let photo6 = UIImage(named: "Tehosekoitin")!
        let track6 = Track(name: "Hetken tie on kevyt", artist: "Tehosekoitin", photo: photo6, rating: 5, about: randomText6)!
        
        let randomText7 = someRandomText()
        let photo7 = UIImage(named: "The_Rasmus")!
        let track7 = Track(name: "Livin' in a World Without You", artist: "The Rasmus", photo: photo7, rating: 3, about: randomText7)!
        
        let randomText8 = someRandomText()
        let photo8 = UIImage(named: "Timo_Maas")!
        let track8 = Track(name: "First day", artist: "Timo Maas", photo: photo8, rating: 3, about: randomText8)!
        
        let randomText9 = someRandomText()
        let photo9 = UIImage(named: "Tori_Amos")!
        let track9 = Track(name: "A Sorta Fairytale" , artist: "Tori Amos", photo: photo9, rating: 3, about: randomText9)!
        
        let randomText10 = someRandomText()
        let photo10 = UIImage(named: "Recovery")!
        let track10 = Track(name: "Love the way you lie" , artist: "Eminem", photo: photo10, rating: 5, about: randomText10)!
        
        tracks += [track1, track2, track3, track4, track5, track6, track7, track8, track9, track10]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TrackTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TrackTableViewCell
        
        // Fetches the appropriate track for the data source layout.
        let track = tracks[indexPath.row]
        
        // Set each of the views in the table view cell to show corresponding data.
        cell.nameLabel.text = track.name
        cell.artistLabel.text = track.artist
        cell.photoImageView.image = track.photo
        
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tracks.removeAtIndex(indexPath.row)
            saveTracks()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = tracks[fromIndexPath.row]
        tracks.removeAtIndex(fromIndexPath.row)
        tracks.insert(itemToMove, atIndex: toIndexPath.row)
        saveTracks()

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let trackDetailViewController = segue.destinationViewController as! TrackViewController
            
            // Get the cell that generated this segue.
            if let selectedTrackCell = sender as? TrackTableViewCell {
                // Fetching the Track object corresponding to the selected cell in the table view.
                let indexPath = tableView.indexPathForCell(selectedTrackCell)!
                let selectedTrack = tracks[indexPath.row]
                trackDetailViewController.track = selectedTrack
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new track.")
        }
        
    }
    
    // To create an action so a user goes back to the track list and see a new song when they click Save button.
    @IBAction func unwindToTrackList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TrackViewController, track = sourceViewController.track {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing track.
                tracks[selectedIndexPath.row] = track
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new track.
                let newIndexPath = NSIndexPath(forRow: tracks.count, inSection: 0)
                tracks.append(track)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the tracks.
            saveTracks()
        }
    }
    
    // MARK: NSCoding
    
    /// Saving the track list.
    func saveTracks() {
        /// Saving the track array to Track.ArchiveURL. Return True if the process was successful.
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tracks, toFile: Track.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tracks...")
        }
    }
    
    /// Adding a method to load saved tracks.
    func loadTracks() -> [Track]? {
        // Unarchiving the data stored in Track.ArchiveURL.path!
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Track.ArchiveURL.path!) as? [Track]
    }
    
}