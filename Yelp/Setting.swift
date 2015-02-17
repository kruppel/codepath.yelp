//
//  Setting.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/16/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import Foundation

class Setting: SettingDelegate {
    
    private var name: String
    private var options: [(name: String, value: String)]
    private var selectedOption: Int
    private var id: String
    
    init(name: String, selectedOption: Int, id: String, options: [(name: String, value: String)]) {
        self.name = name
        self.options = options
        self.selectedOption = selectedOption
        self.id = id
    }
    
    func getName() -> String {
        return name
    }
    
    func getDisplayOptions() -> [(String)] {
        return options.map({ $0.name })
    }
    
    func getSelectedOption() -> Int {
        return selectedOption
    }
    
    func setSelectedOption(index: Int) {
        selectedOption = index
    }

    func serialize() -> (id: String, value: String) {
        return (id, options[selectedOption].1)
    }
}
