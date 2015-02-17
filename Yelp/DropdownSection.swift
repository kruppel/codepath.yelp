//
//  DropdownSection.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {
    
    var label:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.frame = CGRectMake(20, 0, bounds.width, bounds.height)
        label.textColor = UIColor.blackColor()
        addSubview(label)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DropdownSection: SectionDelegate {
    
    var name:String
    var setting:SettingDelegate

    private var options:[String]
    private var selectedOptionIndex:Int
    private var section:Int
    private var tableView:UITableView
    private var isOpen:Bool = false
    
    init(setting: Setting, tableView: UITableView, section: Int) {
        self.name = setting.getName()
        self.options = setting.getDisplayOptions()
        self.selectedOptionIndex = setting.getSelectedOption()
        self.section = section
        self.setting = setting
        self.tableView = tableView
        
        tableView.registerClass(DropdownTableViewCell.self, forCellReuseIdentifier: "DropdownTableViewCell")
    }
    
    func indexPathForRow(row: Int) -> [NSIndexPath] {
        return [NSIndexPath(forRow:row, inSection: section)]
    }
    
    func getCellForRow(row: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DropdownTableViewCell") as DropdownTableViewCell
        if isOpen {
            cell.label.text = options[row]
            cell.accessoryType = row == self.selectedOptionIndex ? .Checkmark : .None
        } else {
            cell.label.text = options[self.selectedOptionIndex]
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    
    func getNumberOfRows() -> Int {
        return isOpen ? options.count : 1
    }
    
    func selectRow(row: Int) {
        if (!isOpen) {
            isOpen = true
            expandRows()
        } else {
            isOpen = false
            selectedOptionIndex = row
            (setting as Setting).setSelectedOption(row)
            collapseRows()
        }
    }
    
    func expandRows() {
        var indexPaths = NSMutableArray()
        for i in 1...self.options.count - 1 {
            var indexPath = NSIndexPath(forRow: i, inSection: section)
            indexPaths.addObject(indexPath)
        }
        
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths(indexPathForRow(0), withRowAnimation: UITableViewRowAnimation.None)
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
        tableView.endUpdates()
    }
    
    func collapseRows() {
        var indexPaths = NSMutableArray()
        for i in 1...self.options.count - 1 {
            var indexPath = NSIndexPath(forRow: i, inSection: section)
            indexPaths.addObject(indexPath)
        }
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
        tableView.reloadRowsAtIndexPaths(indexPathForRow(0), withRowAnimation: UITableViewRowAnimation.None)
        tableView.endUpdates()
    }

    func getFooterView() -> UIView {
        return UIView(frame: CGRectZero)
    }
}