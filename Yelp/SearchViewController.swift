//
//  SearchViewController.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/14/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    let client:YelpClient = YelpClient(consumerKey: "-ORtm5ETDO9U6zfA8B3zxA", consumerSecret: "77uGcDYPYQMyvr0naC9PloA8HLQ", accessToken: "Ef50wwMMNcEULLmKcHE-0px6opop8tH7", accessSecret: "zhvnJZmq27PBOTR4Jv4qzzW-l-g")

    var filterButton:UIBarButtonItem?
    lazy var filterViewController:FilterViewController = FilterViewController()

    lazy var searchBar:UISearchBar = UISearchBar()
    lazy var emptyLabel:UILabel = UILabel()
    lazy var tableView:UITableView = UITableView()
    lazy var refreshControl:UIRefreshControl = UIRefreshControl()

    lazy var businesses:NSArray = []
    var businessesFetched:BooleanType = false

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        var navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.redColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.backgroundColor = UIColor.redColor()

        filterButton = UIBarButtonItem(title: "Filter", style: .Done, target: self, action: "didFilterAction:")

        searchBar.placeholder = "Search"
        searchBar.delegate = self

        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = filterButton

        tableView.estimatedRowHeight = 80.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.frame = CGRectMake(0, navigationBar.frame.height + 20, view.bounds.width, view.bounds.height - navigationBar.frame.height - 20)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SearchResultTableCellView.self, forCellReuseIdentifier: "SearchResultTableViewCell")

        emptyLabel.numberOfLines = 0
        emptyLabel.text = "Search to find businesses."
        emptyLabel.textAlignment = .Center
        emptyLabel.sizeToFit()
        tableView.backgroundView = emptyLabel
        tableView.insertSubview(refreshControl, atIndex: 0)

        view.addSubview(tableView)
        // XXX - remove
        searchBar.text = "Dinner"
        searchBarSearchButtonClicked(searchBar)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultTableViewCell") as SearchResultTableCellView
        let business = businesses[indexPath.row] as Business

        cell.layoutMargins = UIEdgeInsetsZero;
        cell.searchRank = indexPath.row + 1
        cell.setResult(business)

        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = businesses.count
        
        if (count > 0) {
            emptyLabel.hidden = true
            tableView.separatorStyle = .SingleLine
            return 1
        }

        if (businessesFetched) {
            emptyLabel.text = "No businesses found."
        } else {
            emptyLabel.text = "Search for businesses."
        }

        emptyLabel.hidden = false
        tableView.separatorStyle = .None

        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        var query = searchBar.text

        searchBar.resignFirstResponder()
        client.searchWithTerm(query, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var data = response["businesses"] as [NSDictionary]

            self.businessesFetched = true
            self.businesses = map(data, { Business(data:$0 as NSDictionary!) })
            self.tableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            //println(error)
        }
    }

    func didFilterAction(sender: UIBarButtonItem) {
        let filterViewController = FilterViewController()

        filterViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        navigationController?.pushViewController(filterViewController, animated: true)
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