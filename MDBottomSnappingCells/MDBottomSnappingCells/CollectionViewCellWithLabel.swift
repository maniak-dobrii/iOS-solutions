//
//  CollectionViewCellWithLabel.swift
//  MDBottomSnappingCells
//
//  Created by Mikhail Solodovnichenko on 6/21/16.
//  Copyright © 2016 MANIAK_dobrii. All rights reserved.
//


/*
    Just a plain UICollectionViewCell subclass that has UILabel in the center
 */

import UIKit

class CollectionViewCellWithLabel: UICollectionViewCell {

    var label: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupLabel()
    }

    func setupLabel() {
        self.label = UILabel(frame: CGRect.zero)

        if let label = self.label {
            label.textAlignment = .center

            label.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(label)

            // align label from the left and right
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|",
                                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["label": label]));

            // align label from the top and bottom
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|",
                                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["label": label]));
        }
    }

}
