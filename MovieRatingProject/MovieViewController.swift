//
//  MovieViewController.swift
//  MovieRatingProject
//
//  Copyright © 2016 Avel Aguilar. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var movieReview: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MovieTableViewController` in `prepareForSegue(_:sender:)`
     @IBOutlet weak var saveButton: UIBarButtonItem!
     or constructed as part of adding a new movie.
     */
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        // Set up views if editing an existing movie
        if let movie = movie {
            navigationItem.title = movie.name
            nameTextField.text = movie.name
            movieReview.text = movie.review
            photoImageView.image = movie.photo
            ratingControl.rating = movie.rating
        }
        
        // Enable the save button only if the text field has a valid movie name
        checkValidMovieName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMovieName() {
        // Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMovieName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set the photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        // Dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMovieMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMovieMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            let review = movieReview.text
            
            // Set the movie to be passed to MovieTableViewController after the unwind segue.
            movie = Movie(name: name, review: review, photo: photo, rating: rating)
        }
    }
    
    // MARK: Actions
    
    
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        // Make sure view controller is notified when the user picks an image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

}

