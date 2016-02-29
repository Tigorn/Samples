//
//  CollectionViewController.swift
//  Sample
//
//  Created by Lasha Efremidze on 2/23/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//

import UIKit
import AVFoundation

class CollectionViewController: UICollectionViewController {
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Scroll Me"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.insertSubview(visualEffectView, atIndex: 0)
        
        self.collectionView?.backgroundColor = .clearColor()
        self.collectionView?.scrollsToTop = false
        self.collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.registerClass(Cell.self, forCellWithReuseIdentifier: "cell")
        
        let layout = Layout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView?.collectionViewLayout = layout
    }
    
    class func initialize(urls: [NSURL], completion: CollectionViewController -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let images = urls.flatMap { UIImage(data: NSData(contentsOfURL: $0)!) }
            dispatch_async(dispatch_get_main_queue()) {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CollectionViewControllerId") as! CollectionViewController
                viewController.images = images
                completion(viewController)
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
    }
    
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        (cell as? Cell)?.imageView.image = images[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredVertically, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return images[indexPath.item].size.scaleAspectFit(boundingSize: collectionView.bounds.size)
    }
    
}

// MARK: - Layout
private class Layout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffsetForProposedContentOffset(proposedContentOffset) }
        
        let halfHeight = collectionView.bounds.height / 2
        let proposedContentOffsetCenterY = proposedContentOffset.y + halfHeight
        
        let layoutAttributes = layoutAttributesForElementsInRect(collectionView.bounds)?.filter { $0.representedElementCategory == .Cell }
        let closest = layoutAttributes?.sort { abs($0.center.y - proposedContentOffsetCenterY) < abs($1.center.y - proposedContentOffsetCenterY) }.first ?? UICollectionViewLayoutAttributes()
        
        return CGPoint(x: proposedContentOffset.x, y: closest.center.y - halfHeight)
    }
    
}

// MARK: - Cell
private class Cell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.contentView.bounds
        imageView.contentMode = .ScaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
}

// MARK: - CGSize
private extension CGSize {
    
    func scaleAspectFit(boundingSize size: CGSize) -> CGSize {
        var rect = CGRect()
        rect.size = size
        return AVMakeRectWithAspectRatioInsideRect(self, rect).size
    }
    
}
