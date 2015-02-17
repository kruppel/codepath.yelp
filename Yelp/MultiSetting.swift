//
//  MultiSetting.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import Foundation

class MultiSetting: SettingDelegate {
    
    private var name: String
    private var options: [(name: String, value: String)]
    private var id: String
    private var optionDict: [String: Bool]
    private var optionMap: [String: String]

    init(name: String, id: String, options: [(name: String, value: String)]) {
        self.name = name
        self.options = options
        self.id = id
        self.optionDict = [String: Bool]()
        self.optionMap = [String: String]()
        for (name, id) in options {
            optionMap[name] = id
        }
    }
    
    func getName() -> String {
        return name
    }

    func getDisplayOptions() -> [(String)] {
        return options.map({ $0.name })
    }
    
    func setOptionValue(optionName: String, optionValue: Bool) {
        optionDict[optionName] = optionValue
    }

    func isSelected(optionName: String) -> Bool {
        return optionDict[optionName] ?? false
    }

    func serialize() -> (id: String, value: String) {
        var vals:[String] = []

        for (name, value) in optionDict {
            if value == true {
                vals.append(optionMap[name]!)
            }
        }

        var str = ",".join(vals)

        return (id, str)
    }
}