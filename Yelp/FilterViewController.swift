//
//  FilterViewController.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchViewController:SearchViewController?

    lazy var cancelButton:UIBarButtonItem = UIBarButtonItem()
    lazy var searchButton:UIBarButtonItem = UIBarButtonItem()
    lazy var settingsView:UITableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)

    var settingDelegates = [SettingDelegate]()
    var sectionDelegates = [SectionDelegate]()

    let distanceSetting:Setting = Setting(
        name: "Distance",
        selectedOption: 0,
        id: "radius_filter",
        options: [
            ("Best Match", "1600"),
            ("2 blocks", "160"),
            ("6 blocks", "480"),
            ("1 mile", "1609"),
            ("5 miles", "8045")
        ]
    )

    let sortBySetting:Setting = Setting(
        name: "Sort by",
        selectedOption: 0,
        id: "sort",
        options:
        [
            ("Best Match", "0"),
            ("Distance", "1"),
            ("Rating", "2")
        ]
    )

    let categoriesSetting:MultiSetting = MultiSetting(
        name: "Categories",
        id: "category_filter",
        options:
        [
            ("Active Life", "active"),
            ("Arts & Entertainment", "arts"),
            ("Automotive", "auto"),
            ("Beauty & Spas", "beautysvc"),
            ("Bicycles", "bicycles"),
            ("Education", "education"),
            ("Event Planning & Services", "eventservices"),
            ("Financial Services", "financialservices"),
            ("Food", "food"),
            ("Health & Medical", "health"),
            ("Home Services", "homeservices"),
            ("Hotels & Travel", "hotelstravel"),
            ("Local Flavor", "localflavor"),
            ("Local Services", "localservices"),
            ("Mass Media", "massmedia"),
            ("Nightlife", "nightlife"),
            ("Pets", "pets"),
            ("Professional Services", "professional"),
            ("Public Services & Government", "publicservicesgovt"),
            ("Real Estate", "realestate"),
            ("Religious Organizations", "religiousorgs"),
            ("Restaurants", "restaurants"),
            ("Shopping", "shopping")
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        settingsView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)

        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.redColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.backgroundColor = UIColor.redColor()

        cancelButton.title = "Cancel"
        cancelButton.target = self
        cancelButton.action = "didCancel:"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "Filters"

        searchButton.title = "Search"
        searchButton.target = self
        searchButton.action = "didSearch:"
        navigationItem.rightBarButtonItem = searchButton

        sectionDelegates.append(DropdownSection(setting: distanceSetting, tableView: settingsView, section: 0))
        sectionDelegates.append(DropdownSection(setting: sortBySetting, tableView: settingsView, section: 1))
        sectionDelegates.append(SwitchSection(setting: categoriesSetting, tableView: settingsView, section: 2, numCollapsible: 4))

        settingsView.rowHeight = UITableViewAutomaticDimension;
        settingsView.layoutMargins = UIEdgeInsetsZero;
        settingsView.separatorInset = UIEdgeInsetsZero
        settingsView.frame = CGRectMake(10, 0, view.bounds.width - 20, view.bounds.height)
        settingsView.rowHeight = 44
        settingsView.delegate = self
        settingsView.dataSource = self
        settingsView.reloadData()

        view.addSubview(settingsView)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sectionDelegates[indexPath.section].selectRow(indexPath.row)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionDelegates[section].getNumberOfRows()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return sectionDelegates[indexPath.section].getCellForRow(indexPath.row)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionDelegates.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDelegates[section].name
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sectionDelegates[section].getFooterView()
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didSearch(sender: UIBarButtonItem) {
        var params = NSMutableDictionary()

        for section in sectionDelegates {
            let serialized = section.setting.serialize()
            params[serialized.id] = serialized.value
        }

        searchViewController!.searchWithTerm(searchViewController!.searchBar.text, parameters: params)
        dismissViewControllerAnimated(true, completion: nil)
    }

    func didCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
