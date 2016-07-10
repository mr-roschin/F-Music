//
//  RatingControl.swift
//  F-Music
//
//  Created by Alex on 05/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    /// Defining the spacing between buttons
    var spacing = 5
    var stars = 5
    
    // MARK: Initialization
    
    // We chose init?(coder:) initializer, because we will be using the view in the storyboard.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        /// Image of a filled star for a chosen rating.
        let filledStarImage = UIImage(named: "filledStar")
        
        /// Image of an empty star for a chosen rating.
        let emptyStarImage = UIImage(named: "emptyStar")
        
        // For-in loop to create five star-shaped buttons.
        for _ in 0..<5 {
            let button = UIButton()
            
            // When a button wasn't selected.
            button.setImage(emptyStarImage, forState: .Normal)
            // When a button was selected.
            button.setImage(filledStarImage, forState: .Selected)
            // When a button is both highlighted and selected, when a user is in the process of tapping the button.
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            // To make sure that the image doesn't show an additional highlight.
            button.adjustsImageWhenHighlighted = false
            
            // Attaching a ratingButtonTapped to the button object.
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            /// Adding each created button to a ratingButtons array.
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    // Appropriately placting the buttons
    override func layoutSubviews() {
        /// Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    /// Defining a function for tap button action.
    func ratingButtonTapped(button: UIButton) {
        // Finding the selected button in the array of buttons and its index.
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
