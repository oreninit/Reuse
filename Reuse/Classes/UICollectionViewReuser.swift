//
//  UICollectionViewReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 12/04/2018.
//

import UIKit

extension Reuser: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let instance = self[indexPath]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: instance.viewIdentifier, for: indexPath)
        instance.configure(cell)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self[indexPath].select()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self[indexPath].size
    }

}
