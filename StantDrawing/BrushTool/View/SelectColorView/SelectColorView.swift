//
//  SelectColorView.swift
//  StantDrawing
//
//  Created by Stant 02 on 19/02/18.
//  Copyright © 2018 Stant. All rights reserved.
//

import UIKit

public class SelectColorView: UIView {
    
    public static let NIB_NAME = "SelectColorView"
    
    @IBOutlet var contentView: UIView!    
    @IBOutlet weak var viewWhole: UIView!
    @IBOutlet weak var selectColorCollectionView: ColorsCollectionView!
    
    var isExpanded = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        bundle.loadNibNamed(SelectColorView.NIB_NAME, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        initalConfiguration()
    }
    
    public func showSelectColorGroup() {
        self.viewWhole.isHidden   = false
        self.contentView.isHidden = false
    }
    
    public func hideSelectColorGroup() {
        self.viewWhole.isHidden   = true 
        self.contentView.isHidden = true
    }
    
    private func initalConfiguration() {
        viewWhole.layer.cornerRadius = 35
    }
}
