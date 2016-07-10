//
//  Track.swift
//  F-Music
//
//  Created by Alex on 06/07/16.
//  Copyright © 2016 Alexander Roschin. All rights reserved.
//

import UIKit

class Track: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name: String
    var artist: String
    var photo: UIImage?
    var rating: Int
    var about: String?
        
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tracks")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let artistKey = "artist"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        static let aboutKey = "about"
    }
    
    // MARK: Initialization
    
    init?(name: String, artist: String, photo: UIImage?, rating: Int, about: String?) {
        // Initialize stored properties.
        self.name = name
        self.artist = artist
        self.photo = photo
        self.rating = rating
        self.about = about
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        // Encoding the value of each property on the Track class and store them with their corresponding key.
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(artist, forKey: PropertyKey.artistKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
        aCoder.encodeObject(about, forKey: PropertyKey.aboutKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //To unarchive the data, we use decodeObjectForKey(_:) method.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        let artist = aDecoder.decodeObjectForKey(PropertyKey.artistKey) as! String
        
        // Because photo is an optional property of Track, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        let about = aDecoder.decodeObjectForKey(PropertyKey.aboutKey) as? String
        
        // Must call designated initializer.
        self.init(name: name, artist: artist, photo: photo, rating: rating, about: about)
    }
    
}