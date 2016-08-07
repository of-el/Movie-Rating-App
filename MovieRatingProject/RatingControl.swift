//
//  RatingControl.swift
//  MovieRatingProject
//
//  Copyright © 2016 Avel Aguilar. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    // This "rating" property observer is called immediately aftter the property's value is set
    // Here we include a setNeedsLayout() method which will trigger a layout update everytime the rating changes
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    
    let spacing = 5
    let starCount = 5

    // Initialization for Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set rating button size to size of frames height
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each buttons origin by the length of the button plus a buffer spacing
        for (index, button) in ratingButtons.enumerate() {
            // enumerate() method returns a collection of elements in ratingButtons array paired with their indices.
            // For each tuple in the collection, the for-in loop binds the values of the index and button in that tuple to local variables, index and button.
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected
            button.selected = index < rating
        }
    }
}
