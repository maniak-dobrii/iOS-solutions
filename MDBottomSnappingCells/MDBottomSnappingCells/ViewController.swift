//
//  ViewController.swift
//  MDBottomSnappingCells
//
//  Created by Mikhail Solodovnichenko on 6/18/16.
//  Copyright © 2016 MANIAK_dobrii. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    func setupCollectionView() {
        // Setting up collection view with special layout
        // This makes the whole point of this demo
        let bottomSnappingLayout = BottomSnappingCollectionViewLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: bottomSnappingLayout)

        // nothing interesting there
        configureOtherCollectionViewStuff()
    }

    // MARK - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // This makes items look like UITableViewCells in terms of the width
        return CGSize(width: collectionView.bounds.size.width, height: 44.0)
    }
}


// Other irrelevant collection View stuff
extension ViewController : UICollectionViewDataSource {

    func configureOtherCollectionViewStuff() {
        // Add to view hierachy and create constraints
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.collectionView!)

        let views = ["collectionView" : self.collectionView!]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))

        self.collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true

        self.collectionView?.register(CollectionViewCellWithLabel.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    // MARK - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellWithLabel
        cell.backgroundColor = #colorLiteral(red: 0.4028071761, green: 0.7315050364, blue: 0.2071235478, alpha: 1)
        cell.label?.text = "Item #\(indexPath.row)"
        return cell
    }
}

