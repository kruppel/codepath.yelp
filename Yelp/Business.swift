//
//  Business.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/15/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import Foundation

class Business: NSObject {
    var categories:Array<NSDictionary> = []
    var id:NSString?
    var name:NSString?
    var image:UIImage?
    var imageURL:NSURL?
    var location:NSDictionary?
    var reviewCount:Int?
    var ratingImageSmallURL:NSURL?
    var ratingImageSmall:UIImage?
    var ratingImageLargeURL:NSURL?
    var ratingImageLarge:UIImage?
    
    init(data: NSDictionary) {
        let categoryList = data.valueForKey("categories") as [[NSString]]!

        for category in categoryList {
            categories.append(["name": category[0], "id": category[1]])
        }

        id = data["id"] as NSString!
        name = data["name"] as NSString!
        imageURL = NSURL(string: data["image_url"] as NSString!)
        location = data["location"] as? NSDictionary
        ratingImageLargeURL = NSURL(string: data["rating_img_url_large"] as NSString!)
        reviewCount = data["review_count"] as Int!

        super.init()
    }

    var categoryNames: String {
        get {
            var categoryNames = map(self.categories, { $0["name"] as String! }) as [String]

            return ", ".join(categoryNames)
        }
    }
}