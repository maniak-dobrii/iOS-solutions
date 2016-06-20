//
//  BottomSnappingCollectionViewLayout.swift
//  MDBottomSnappingCells
//
//  Created by Mikhail Solodovnichenko on 6/18/16.
//  Copyright © 2016 MANIAK_dobrii. All rights reserved.
//

import UIKit

class BottomSnappingCollectionViewLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Do we need to stick cells to the bottom or not
        var shiftDownNeeded = false

        // Size of all cells without modifications
        let allContentSize = super.collectionViewContentSize()

        // If there are not enough cells to fill collection view vertically we shift them down
        let diff = self.collectionView!.bounds.size.height - allContentSize.height
        if Double(diff) > DBL_EPSILON {
            shiftDownNeeded = true
        }

        // Ask for common attributes
        let attributes = super.layoutAttributesForElements(in: rect)

        if let attributes = attributes {
            if shiftDownNeeded {
                for element in attributes {
                    let frame = element.frame;
                    // shift all the cells down by the difference of heights
                    element.frame = frame.offsetBy(dx: 0, dy: diff);
                }
            }
        }
        
        return attributes;
    }
}
