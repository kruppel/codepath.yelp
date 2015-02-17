//
//  SearchResultTableCellView.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/15/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class SearchResultTableCellView: UITableViewCell {

    var result:Business?
    var searchRank:Int?

    lazy var titleLabel:UILabel = UILabel()
    lazy var bizImageView:UIImageView = UIImageView()
    lazy var ratingImageView:UIImageView = UIImageView()
    lazy var reviewCountLabel:UILabel = UILabel()
    lazy var addressLabel:UILabel = UILabel()
    lazy var categoriesLabel:UILabel = UILabel()
    lazy var distanceLabel:UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        bizImageView.contentMode = .ScaleAspectFit
        ratingImageView.contentMode = .ScaleAspectFit

        titleLabel.font = UIFont(descriptor: titleLabel.font.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold), size: 16)
        reviewCountLabel.font = reviewCountLabel.font.fontWithSize(13)
        reviewCountLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        addressLabel.font = addressLabel.font.fontWithSize(13)
        categoriesLabel.font = categoriesLabel.font.fontWithSize(13)
        categoriesLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        categoriesLabel.numberOfLines = 0
        categoriesLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping

        bizImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        ratingImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        reviewCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        categoriesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        distanceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        addSubview(bizImageView)
        addSubview(titleLabel)
        addSubview(ratingImageView)
        addSubview(reviewCountLabel)
        addSubview(addressLabel)
        addSubview(categoriesLabel)
        addSubview(distanceLabel)

        var viewsDict = [
            "image": bizImageView,
            "name": titleLabel,
            "distance": distanceLabel,
            "rating": ratingImageView,
            "reviews": reviewCountLabel,
            "address": addressLabel,
            "categories": categoriesLabel
        ]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[image(80)]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[image(80)]-10-[name]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[name]-3-[rating(24)]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-10-[rating(96)]-3-[reviews]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[name]-8-[reviews]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-10-[address]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[rating]-3-[address]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-10-[address]", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[address]-3-[categories]-10-|", options: nil, metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[image]-10-[categories]-10-|", options: nil, metrics: nil, views: viewsDict))
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setResult(business: Business) {
        let count = business.reviewCount
        let name = business.name
        let location = business.location!
        let addresses = location.valueForKey("address") as [String]
        let neighborhoods = location.valueForKey("neighborhoods") as [String]
        let categories = business.categoryNames

        fetchImageForView(bizImageView, url: business.imageURL!)
        fetchImageForView(ratingImageView, url: business.ratingImageLargeURL!)

        result = business
        titleLabel.text = String(format: "%d. %@", searchRank!, name!)
        reviewCountLabel.text = String(format: "%d Reviews", count!)

        if (addresses.count > 0 && neighborhoods.count > 0) {
            addressLabel.text = String(format: "%@, %@", addresses[0], neighborhoods[0])
        } else if (addresses.count > 0) {
            addressLabel.text = String(format: "%@", addresses[0])
        } else if (neighborhoods.count > 0) {
            addressLabel.text = String(format: "%@", neighborhoods[0])
        }

        categoriesLabel.text = String(categories)
    }

    func fetchImageForView(imageView: UIImageView, url: NSURL) {
        var request = NSMutableURLRequest(URL: url)
        var cached = UIImageView.sharedImageCache().cachedImageForRequest(request as NSURLRequest)
        
        if (cached != nil) {
            imageView.image = cached
        } else {
            request.addValue("image/*", forHTTPHeaderField: "Accept")
            imageView.alpha = 0
            imageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) -> Void in
                UIView.animateWithDuration(0.4, animations: {
                    imageView.alpha = 1
                })
                imageView.image = image
            }, failure: nil)
        }
    }
}
