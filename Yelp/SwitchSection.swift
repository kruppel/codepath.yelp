//
//  SwitchSection.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class ExpandableSwitchTableFooterView: UITableViewHeaderFooterView {

    var label:UILabel!
    var delegate:SwitchSection!

    override init(frame: CGRect) {
        super.init(frame: frame)

        label = UILabel()
        label.frame = CGRectMake(0, 0, frame.width, frame.height)
        label.font = UIFont(descriptor: label.font.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold), size: 16)
        label.backgroundColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        label.text = "See All"

        contentView.addSubview(label)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTap:"))
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didTap(sender: AnyObject) {
        delegate.didTapFooter()
    }
}

class SwitchTableViewCell: UITableViewCell {

    var delegate:SectionDelegate?
    var name:String?
    var label:UILabel = UILabel()
    var toggle:UISwitch = UISwitch()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.frame = CGRectMake(20, 0, bounds.width, bounds.height)
        label.textColor = UIColor.blackColor()
        toggle.frame = CGRectMake(bounds.width + 10, 8, toggle.frame.width, toggle.frame.height)
        toggle.addTarget(self, action: "didToggle:", forControlEvents: .AllTouchEvents)
        
        addSubview(label)
        addSubview(toggle)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didToggle(sender: AnyObject) {
        (delegate?.setting as MultiSetting).setOptionValue(name!, optionValue: toggle.on)
    }
}

class SwitchSection: SectionDelegate {
    
    var name: String
    var setting:SettingDelegate

    private var options:[String]
    private var section:Int
    private var tableView:UITableView
    private var numCollapsible:Int = 0
    private var isOpen:Bool
    
    init(setting: MultiSetting, tableView: UITableView, section: Int, numCollapsible: Int?) {
        self.name = setting.getName()
        self.options = setting.getDisplayOptions()
        self.section = section
        self.setting = setting
        self.tableView = tableView

        if (numCollapsible != nil) {
            self.isOpen = false
            self.numCollapsible = numCollapsible!
        } else {
            self.isOpen = true
        }
        
        tableView.registerClass(SwitchTableViewCell.self, forCellReuseIdentifier: "SwitchTableViewCell")
    }
    
    func indexPathForRow(row: Int) -> [NSIndexPath] {
        return [NSIndexPath(forRow:row, inSection: section)]
    }
    
    func getCellForRow(row: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchTableViewCell") as SwitchTableViewCell
        let cellName = options[row]

        cell.delegate = self
        cell.name = cellName
        cell.label.text = cellName
        let isEnabled = (setting as MultiSetting).isSelected(cellName)
        cell.toggle.setOn(isEnabled, animated: true)
        
        return cell
    }
    
    func getNumberOfRows() -> Int {
        return isOpen ? options.count : numCollapsible
    }
    
    func selectRow(row: Int) {
        let multiSetting = setting as MultiSetting
        let cell = getCellForRow(row) as SwitchTableViewCell
        let cellName = options[row]
        let isEnabled = !multiSetting.isSelected(cellName)

        multiSetting.setOptionValue(cellName, optionValue: isEnabled)
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: row, inSection: section)], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.endUpdates()
    }

    func getFooterView() -> UIView {
        if (isOpen) {
            return UIView(frame: CGRectZero)
        }

        var footerView = ExpandableSwitchTableFooterView(frame: CGRectMake(0, 0, tableView.bounds.width, 40))

        footerView.delegate = self

        return footerView
    }

    func didTapFooter() {
        println(isOpen)
        if isOpen {
            return
        }

        isOpen = !isOpen
        var indexPaths = NSMutableArray()
        for i in numCollapsible...options.count - 1 {
            var indexPath = NSIndexPath(forRow: i, inSection: section)
            indexPaths.addObject(indexPath)
        }
        var indexPath = NSIndexPath(forRow: numCollapsible - 1, inSection: section)
        self.tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Top)
        self.tableView.endUpdates()
    }
}