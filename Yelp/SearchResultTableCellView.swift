//
//  SearchResultTableCellView.swift
//  Yelp
//
//  Created by Kurt Ruppel on 2/15/15.
//  Copyright (c) 2015 kruppel. All rights reserved.
//

import UIKit

class SearchResultTableCellView: UITableViewCell {

    lazy var titleLabel:UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.text = "Title"
        titleLabel.frame = bounds

        addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
