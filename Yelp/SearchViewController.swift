//
//  SearchViewController.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/14/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

struct Business{
    var categories:NSDictionary
    var id:NSString
    var name:NSString
    var image:UIImage
    var imageURL:NSURL
    var location:NSDictionary
    var reviewCount:Int
    var ratingImageSmallURL:NSURL
    var ratingImageSmall:UIImage
    var ratingImageLargeURL:NSURL
    var ratingImageLarge:UIImage

    func loadData(data: NSDictionary) {
        println(data)
    }
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    let client:YelpClient = YelpClient(consumerKey: "-ORtm5ETDO9U6zfA8B3zxA", consumerSecret: "77uGcDYPYQMyvr0naC9PloA8HLQ", accessToken: "Ef50wwMMNcEULLmKcHE-0px6opop8tH7", accessSecret: "zhvnJZmq27PBOTR4Jv4qzzW-l-g")

    var filterButton:UIBarButtonItem?
    lazy var searchBar:UISearchBar = UISearchBar()
    lazy var tableView:UITableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()

        var navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.redColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.backgroundColor = UIColor.redColor()

        filterButton = UIBarButtonItem(title: "Filter", style: .Done, target: self, action: "didFilterAction")
        searchBar.placeholder = "Search"

        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = filterButton

        tableView.separatorInset = UIEdgeInsetsZero
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SearchResultTableCellView.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        view.addSubview(tableView)

        client.searchWithTerm("dinner", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultTableViewCell") as SearchResultTableCellView

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func didFilterAction(sender: UIBarButtonItem) {
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