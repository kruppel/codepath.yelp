//
//  SearchViewController.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/14/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var searchView:UISearchBar = UISearchBar()
    lazy var tableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.frame = view.bounds

        tableView.separatorInset = UIEdgeInsetsZero
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SearchResultTableCellView.self, forCellReuseIdentifier: "SearchResultTableViewCell")

        view.addSubview(searchView)
        //view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultTableViewCell") as SearchResultTableCellView

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
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
