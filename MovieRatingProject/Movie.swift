//
//  Movie.swift
//  MovieRatingProject
//
//  Copyright © 2016 Avel Aguilar. All rights reserved.
//

import UIKit

class Movie {
    // MARK: Properties
    
    var name: String
    var review: String?
    var photo: UIImage?
    var rating: Int
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let reviewKey = "review"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("movies")
    
    // MARK: Initialization
    
    init?(name: String, review: String?, photo: UIImage?, rating: Int) {
        // Initialized stored properties
        self.name = name
        self.review = review
        self.photo = photo
        self.rating = rating
        
        // Initialization will fail if there is no name or if rating is negative
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
