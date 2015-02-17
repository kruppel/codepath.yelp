//
//  SettingDelegate.swift
//  
//
//  Created by Kurt Ruppel on 2/16/15.
//
//

protocol SettingDelegate {
    func serialize() -> (id: String, value: String)
}