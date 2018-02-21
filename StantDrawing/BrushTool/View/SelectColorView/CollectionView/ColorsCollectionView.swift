//
//  ColorsCollectionView.swift
//  StantDrawing
//
//  Created by Stant 02 on 21/02/18.
//  Copyright © 2018 Stant. All rights reserved.
//

import Foundation

public class ColorsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var brushDelegate: BrushToolContract?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let bundle    = Bundle(for: self.classForCoder)
        let colorCell = UINib(nibName: ColorCell.NIB_NAME, bundle: bundle)
        colorCell.instantiate(withOwner: self, options: nil)
        
        self.register(colorCell, forCellWithReuseIdentifier: ColorCell.IDENTIFIER)
        
        self.delegate   = self
        self.dataSource = self
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorGenerator.getAll().count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: ColorCell.IDENTIFIER, for: indexPath) as! ColorCell
        
        let currentColor = UIColor(hex: ColorGenerator.getAll()[indexPath.row])
        
        cell.palleteView.backgroundColor  = currentColor
        cell.selectedView.backgroundColor = currentColor
        
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))

        self.inputViewController?.present(alert, animated: true, completion: nil)
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        
        brushDelegate?.changeColor(ColorGenerator.getAll()[indexPath.row])
        
        cell.selectedView.backgroundColor = UIColor.white
        
        print("selected")
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) == nil { return }
        
        let cell: ColorCell = collectionView.cellForItem(at: indexPath) as! ColorCell
        
        
        cell.selectedView.backgroundColor = UIColor(hex: ColorGenerator.getAll()[indexPath.row])
        
        print("unselected")
        
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60,
                      height: 50)
    }
    
}
