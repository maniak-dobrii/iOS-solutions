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
    var controlButtonsView: UIView?
    var numberOfItems: Int = 3

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

    // This one is just to make demo more interactive and expressive
    func updateNumberOfItems(dif: Int) {
        self.numberOfItems += dif

        if self.numberOfItems < 0 {
            self.numberOfItems = 0
        }

        self.collectionView?.reloadData()
    }
}


// Other irrelevant collection view stuff
extension ViewController : UICollectionViewDataSource {

    // Tons of boilerplate configuration, nothing interesting here at all
    func configureOtherCollectionViewStuff() {
        self.controlButtonsView = UIView(frame: CGRect.zero)
        self.controlButtonsView?.translatesAutoresizingMaskIntoConstraints = false
        self.configureControlButtons(inView: self.controlButtonsView!)

        self.view.addSubview(self.controlButtonsView!)

        // Add to view hierachy and create constraints
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.collectionView!)

        let views = ["collectionView" : self.collectionView!, "controlButtonsView" : self.controlButtonsView!]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[controlButtonsView]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-[controlButtonsView(60)]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))

        self.collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true

        self.collectionView?.register(CollectionViewCellWithLabel.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    func configureControlButtons(inView superview:UIView) {
        let incButton = UIButton(frame: CGRect.zero)
        incButton.translatesAutoresizingMaskIntoConstraints = false
        incButton.addTarget(self, action: #selector(ViewController.onIncButtonTapped(_:)), for: .touchUpInside)
        incButton.setTitle("+", for: UIControlState(rawValue: 0)) // normal is missing, filed rdar://26903126
        incButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState(rawValue: 0))

        let decButton = UIButton(frame: CGRect.zero)
        decButton.translatesAutoresizingMaskIntoConstraints = false
        decButton.addTarget(self, action: #selector(ViewController.onDecButtonTapped(_:)), for: .touchUpInside)
        decButton.setTitle("-", for: UIControlState(rawValue: 0)) // normal is missing, filed rdar://26903126
        decButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState(rawValue: 0))

        superview.addSubview(incButton)
        superview.addSubview(decButton)

        let views = ["incButton" : incButton, "decButton" : decButton]
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[incButton(decButton)]-0-[decButton]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views));
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[incButton]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[decButton]-0-|",
                                                                options: NSLayoutFormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
    }

    // MARK - Actions
    func onIncButtonTapped(_ sender: AnyObject?) {
        updateNumberOfItems(dif: 1)
    }

    func onDecButtonTapped(_ sender: AnyObject?) {
        updateNumberOfItems(dif: -1)
    }

    // MARK - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellWithLabel
        cell.backgroundColor = #colorLiteral(red: 0.4028071761, green: 0.7315050364, blue: 0.2071235478, alpha: 1)
        cell.label?.text = "Item #\(indexPath.row)"
        return cell
    }
}

