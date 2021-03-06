//
//  ViewController.swift
//  Sample
//
//  Created by Lasha Efremidze on 1/27/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.collectionViewLayout = {
            let layout = PinterestLayout()
            layout.delegate = self
            return layout
        }()
        
//        self.collectionView?.collectionViewLayout = CollectionViewFlowLayout()
//        (self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: 100, height: 100)
        
        self.collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activity.center = self.view.center
        activity.startAnimating()
        self.view.addSubview(activity)
        DispatchQueue.global().async { [unowned self] in
            self.items = (0...10).map { _ in Item.make() }
            DispatchQueue.main.async { [unowned self] in
                activity.stopAnimating()
                self.collectionView?.reloadData()
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        cell.configure(items[indexPath.item])
        return cell
    }
    
}

// MARK: - PinterestLayoutDelegate
extension ViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let cell = Cell.makeCell(width: width)
        cell.configure(items[indexPath.row])
        return cell.stackView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
}

//class CollectionViewFlowLayout: UICollectionViewFlowLayout {
//    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as! UICollectionViewLayoutAttributes
//        layoutAttributes.size.width = collectionView!.bounds.width / 2
//        return layoutAttributes
//    }
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let layoutAttributes = super.layoutAttributesForElements(in: rect)!
//        var array = [UICollectionViewLayoutAttributes]()
//        array += layoutAttributes.flatMap { layoutAttributesForItem(at: $0.indexPath) }
//        return array
//    }
//    
//}
