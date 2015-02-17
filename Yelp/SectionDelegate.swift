//
//  SectionDelegate.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

protocol SectionDelegate {
    
    var name:String { get }
    var setting:SettingDelegate { get }
    
    func getCellForRow(row: Int) -> UITableViewCell
    func getNumberOfRows() -> Int
    func selectRow(row: Int)
    func getFooterView() -> UIView
}