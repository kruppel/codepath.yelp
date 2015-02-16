//
//  FilterViewController.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class CategoryPickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerView:UIPickerView?
    let categories = [
        ["name": "Active Life", "id": "active"],
        ["name": "Arts & Entertainment", "id": "arts"],
        ["name": "Automotive", "id": "auto"],
        ["name": "Beauty & Spas", "id": "beautysvc"],
        ["name": "Bicycles", "id": "bicycles"],
        ["name": "Education", "id": "education"],
        ["name": "Event Planning & Services", "id": "eventservices"],
        ["name": "Financial Services", "id": "financialservices"],
        ["name": "Food", "id": "food"],
        ["name": "Health & Medical", "id": "health"],
        ["name": "Home Services", "id": "homeservices"],
        ["name": "Hotels & Travel", "id": "hotelstravel"],
        ["name": "Local Flavor", "id": "localflavor"],
        ["name": "Local Services", "id": "localservices"],
        ["name": "Mass Media", "id": "massmedia"],
        ["name": "Nightlife", "id": "nightlife"],
        ["name": "Pets", "id": "pets"],
        ["name": "Professional Services", "id": "professional"],
        ["name": "Public Services & Government", "id": "publicservicesgovt"],
        ["name": "Real Estate", "id": "realestate"],
        ["name": "Religious Organizations", "id": "religiousorgs"],
        ["name": "Restaurants", "id": "restaurants"],
        ["name": "Shopping", "id": "shopping"]
    ]

    lazy var categoryIds: NSArray {
        get {
            return map(categories, { $0["id"] })
        }
    }

    lazy var categoryNames: NSArray {
        get {
            return map(categories, { $0["name"] })
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        pickerView = UIPickerView()
        pickerView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        pickerView!.dataSource = self
        pickerView!.delegate = self
        contentView.addSubview(pickerView!)
        contentView.backgroundColor = UIColor.greenColor()
        contentView.addConstraints([
            NSLayoutConstraint(item: pickerView!, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: pickerView!, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: pickerView!, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: pickerView!, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        ])
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoryNames[row] as String!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}

class FilterViewController: UIViewController {

    let categories:NSArray! = []

    lazy var navigationBar:UINavigationBar = UINavigationBar()
    lazy var cancelButton:UIBarButtonItem = UIBarButtonItem()
    lazy var searchButton:UIBarButtonItem = UIBarButtonItem()
    lazy var categoriesSection:UITableView = UITableView()

    lazy var categoriesLabel:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.title = "Cancel"
        cancelButton.target = self
        cancelButton.action = "didCancel:"
        navigationItem.leftBarButtonItem = cancelButton

        navigationItem.title = "Filters"

        searchButton.title = "Search"
        searchButton.target = self
        searchButton.action = "didSearch:"
        navigationItem.rightBarButtonItem = searchButton

        // Category
        categoriesLabel.text = "Categories"
        categoriesLabel.font = UIFont(descriptor: categoriesLabel.font.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold), size: 15)
        categoriesLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        var categoryCell = CategoryPickerCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        categoriesSection.addSubview(categoryCell)
        categoriesSection.estimatedRowHeight = 80.0;
        categoriesSection.rowHeight = UITableViewAutomaticDimension;
        // Most Popular
        // Distance
        // Sort By

        categoriesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        categoriesSection.setTranslatesAutoresizingMaskIntoConstraints(false)
        categoriesSection.backgroundColor = UIColor.blueColor()
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(categoriesLabel)
        view.addSubview(categoriesSection)
        
        var viewsDict = [
            "categoriesLabel": categoriesLabel,
            "categoriesSection": categoriesSection
        ]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-90-[categoriesLabel]-10-[categoriesSection(40)]", options: nil, metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[categoriesLabel]-10-|", options: nil, metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[categoriesSection]-10-|", options: nil, metrics: nil, views: viewsDict))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didSearch(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }

    func didCancel(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
