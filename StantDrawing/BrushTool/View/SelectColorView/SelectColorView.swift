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
    
    
    private func initalConfiguration() {
        
    }
}
