//
//  GenericCollectionView.swift
//  DilTestPartOne
//
//  Created by Raj Rathod on 10/10/23.
//

import Foundation
import UIKit

class GenericCollectionDataSource<T: UICollectionViewCell>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var didSelect: (T, Int) -> Void = { _, _  in }
    var configure : ((T, Int) -> Void)?
    var identifier = String()
    var array: [Any] = []
    var sizeItem = CGSize()
    
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func loadCell(atIndexPath indexPath: IndexPath, forCollectionView collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        configure?(cell as! T, indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.loadCell(atIndexPath: indexPath, forCollectionView: collectionView)
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        didSelect(cell as! T, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeItem
    }
}
