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
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        
        cell.selectedView.backgroundColor = UIColor.white
        
        let alert = UIAlertController(title: "Atenção", message: brushDelegate?.getMessage(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: { (alertAction) in
            cell.selectedView.backgroundColor = UIColor(hex: ColorGenerator.getAll()[indexPath.row])
        }))
        
        alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.brushDelegate?.changeColor(ColorGenerator.getAll()[indexPath.row])
        }))
        
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView.cellForItem(at: indexPath) == nil { return }
        
        let cell: ColorCell = collectionView.cellForItem(at: indexPath) as! ColorCell
        
        cell.selectedView.backgroundColor = UIColor(hex: ColorGenerator.getAll()[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60,
                      height: 50)
    }
    
}
