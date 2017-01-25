//
//  SegmentCell.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

import UIKit

class SegmentCell: UICollectionViewCell {
    let fontSize = 16.0
    var selectedFontColor: UIColor!
    var deselectedFontColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NeutraTextTF-DemiAlt", size: 17)
        return label
    }()
    
    // adjust the SegmentedBar Cell when selected
    override var highlighted: Bool {
        didSet {
            cellTitle.textColor = highlighted ? selectedFontColor: deselectedFontColor
        }
    }
    override var selected: Bool {
        didSet {
            cellTitle.textColor = selected ?  selectedFontColor: deselectedFontColor
        }
    }
    func setupViews() {
        addSubview(cellTitle)
        addConstraintsWithFormat("H:[v0]", views: cellTitle)
        addConstraintsWithFormat("V:[v0]", views: cellTitle)
        setupConstraints()
    }
    
    func setupConstraints() {
        addConstraint(NSLayoutConstraint(item: cellTitle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: cellTitle, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
