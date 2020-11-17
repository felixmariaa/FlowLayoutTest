//
//  ColumnFlowLayout.swift
//  SFCalendar
//
//  Created by Felix Marianayagam on 11/11/20.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    let cellsPerRow: Int
    let cellsPerColumn: Int
    var proposedCO = CGPoint.zero

    init(cellsPerRow: Int, cellsPerColumn: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        self.cellsPerColumn = cellsPerColumn
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let marginsAndInsets1 = sectionInset.top + sectionInset.bottom + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + minimumInteritemSpacing * CGFloat(cellsPerColumn - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets1) / CGFloat(cellsPerColumn)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        if let ip = collectionView.indexPathsForSelectedItems?.first {
            if cellsPerColumn == 2 {
                // Calculate the proposedContentOffset and set it in the targetContentOffset func
                let item = ip.item
                let y = (CGFloat(item) * itemHeight) - sectionInset.top + sectionInset.bottom + collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom + minimumInteritemSpacing * CGFloat(item)
                proposedCO = CGPoint(x: 0, y: y)
            }

            // ISSUE: Setting the textAlignment here, doesn't seem to be smooth transition.
            /*
            DispatchQueue.main.async {
                if let cell = collectionView.cellForItem(at: ip) as? CollectionViewCell {
                    cell.label.textAlignment = self.cellsPerColumn == 2 ? .right : .left
                }
            }
            */
        }
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        // This is not getting called. Is this needed?
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if proposedCO != .zero {
            return proposedCO
        }
        return proposedContentOffset
    }
}
