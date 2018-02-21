//
//  ColorCell.swift
//  StantDrawing
//
//  Created by Stant 02 on 21/02/18.
//  Copyright © 2018 Stant. All rights reserved.
//

import Foundation

public class ColorCell: UICollectionViewCell {
    
    static let NIB_NAME   = "ColorCell"
    static let IDENTIFIER = "ColorCellIdentifier"
    
    @IBOutlet weak var palleteView: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    override public func awakeFromNib() {
        palleteView.layer.cornerRadius  = palleteView.frame.height/2
        selectedView.layer.cornerRadius = selectedView.frame.height/2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
