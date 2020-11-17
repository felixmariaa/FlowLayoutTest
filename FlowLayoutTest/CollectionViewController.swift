//
//  CollectionViewController.swift
//  SFCalendar
//
//  Created by Felix Marianayagam on 11/11/20.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    let months = Year.getMonths()
    var isSingleColumnLayout = false
    var editingCell: CollectionViewCell!

    let columnLayout3x4 = ColumnFlowLayout(
        cellsPerRow: 3,
        cellsPerColumn: 4, // Number of cells that should display in a single page.
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    let singleColumnLayout = ColumnFlowLayout(
        cellsPerRow: 1,
        cellsPerColumn: 2, // Number of cells that should display in a single page.
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.collectionViewLayout = columnLayout3x4
        collectionView?.contentInsetAdjustmentBehavior = .always
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Change the layout from 3x4 to single.
        collectionView.setCollectionViewLayout(isSingleColumnLayout ? columnLayout3x4 : singleColumnLayout, animated: true)
        isSingleColumnLayout.toggle()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.label.text = months[indexPath.row].name
        cell.label.textAlignment = isSingleColumnLayout ? .right : .left
        cell.backgroundColor = months[indexPath.row].color
        return cell
    }
}

struct Year {
    static func getMonths() -> [Month] {
        let months = [
            Month(id: 1, name: "Jan", days: 31, color: .cyan),
            Month(id: 2, name: "Feb", days: 28, color: .orange),
            Month(id: 3, name: "Mar", days: 31, color: .blue),
            Month(id: 4, name: "Apr", days: 30, color: .gray),
            Month(id: 5, name: "May", days: 31, color: .yellow),
            Month(id: 6, name: "Jun", days: 30, color: .systemIndigo),
            Month(id: 7, name: "Jul", days: 31, color: .purple),
            Month(id: 8, name: "Aug", days: 31, color: .orange),
            Month(id: 9, name: "Sep", days: 30, color: .blue),
            Month(id: 10, name: "Oct", days: 31, color: .cyan),
            Month(id: 11, name: "Nov", days: 30, color: .brown),
            Month(id: 12, name: "Dec", days: 31, color: .green)
        ]
        return months
    }
}

struct Month {
    var id: Int
    var name: String
    var days: Int
    var color: UIColor
    
    init(id: Int, name: String, days: Int, color: UIColor) {
        self.id = id
        self.name = name
        self.days = days
        self.color = color
    }
}
