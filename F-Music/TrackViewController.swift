//
//  TrackViewController.swift
//  F-Music
//
//  Created by Alex on 05/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//

import UIKit
import LoremSwiftum

//adding the ability to identify class ViewController as a UITextFieldDelegate and adding UIImagePickerControllerDelegate and UINavigationControllerDelegate to adopt the protocols
class TrackViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    /// Track name
    @IBOutlet weak var nameTextField: UITextField!
    /// Artist name
    @IBOutlet weak var artistTextField: UITextField!
    /// Cover image
    @IBOutlet weak var photoImageView: UIImageView!
    /// Reference to RatingControl.swift of the track
    @IBOutlet weak var ratingControl: RatingControl!
    /// Description box.
    @IBOutlet weak var aboutTextView: UITextView!
    /// Save button in the top right corner.
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `TrackTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new track.
     */
    var track: Track?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Defining someLoremText (will use it in aboutTextView)
        var someLoremText = Lorem.sentences(3)
        // Set the <200 characters long description limit.
        repeat {
            someLoremText = Lorem.sentences(3)
        } while someLoremText.characters.count > 200
        
        
        /// Handle the track name text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        /// Handle the artist name text field's user input through delegate callbacks.
        artistTextField.delegate = self
        /// Adding someLoremText to track's description box.
        aboutTextView.text = someLoremText
        
        
        // Set up views if editing an existing Track.
        if let track = track {
            navigationItem.title = track.name
            nameTextField.text   = track.name
            artistTextField.text = track.artist
            photoImageView.image = track.photo
            ratingControl.rating = track.rating
            aboutTextView.text = track.about
        }
        
        // Enable the Save button only if the text field has a valid Track name.
        checkValidTrackName()
        
    }
    
    //make text of aboutTextView to be aligned to the top
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        aboutTextView.setContentOffset(CGPointZero, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Dismiss the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTrackName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidTrackName() {
        // Disable the Save button if the track title field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the image picker controller if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // We use the original, unedited image for track cover photo.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Tell photoImageView to display the chosen image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (either modal or push presentation), we dismiss the view controller in two different ways.
        let isPresentingInAddTrackMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTrackMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            // Creating constants.
            /// Track name constant.
            let name = nameTextField.text ?? ""
            /// Artist name constant.
            let artist = artistTextField.text ?? ""
            /// Cover image constant.
            let photo = photoImageView.image
            /// Rating constant.
            let rating = ratingControl.rating
            /// Description constant.
            let about = aboutTextView.text
            
            
            // Set the track to be passed to TrackTableViewController after the unwind segue.
            track = Track(name: name, artist: artist, photo: photo, rating: rating, about: about)
        }
    }

    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Dismiss the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Allows pictures to be choosen from Photo Library (not taken with camera).
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}

