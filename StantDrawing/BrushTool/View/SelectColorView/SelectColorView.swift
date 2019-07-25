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
    
    @IBOutlet weak var expandButton: UIButton!
    
    @IBOutlet weak var animationBaseContentView: UIView!
    @IBOutlet weak var animationBaseViewWhole: UIView!
    @IBOutlet weak var animationBaseCollectionView: UIView!
    
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
        self.viewWhole.backgroundColor = UIColor(hex: "#F0F0F0")
        self.selectColorCollectionView.backgroundColor = UIColor(hex: "#F0F0F0")
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        initalConfiguration()
    }
    
    @IBAction func expandButton(_ sender: Any) {
        
        if isExpanded {
            
            UIView.animate(withDuration: 0.5) {
                self.setupCollapsed()
            }
            
            isExpanded = false
        } else {
            
            UIView.animate(withDuration: 0.5) {                
                self.expandButton.imageView?.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                
                self.frame.size.width = self.animationBaseViewWhole.frame.width
                self.frame.origin.x   = (self.superview?.frame.width)! - (self.frame.width + 30)
                
                self.viewWhole.frame.size.width = self.animationBaseViewWhole.frame.width + 20
                self.viewWhole.frame.origin.x   = self.animationBaseViewWhole.frame.origin.x
                
                self.selectColorCollectionView.frame.size.width = self.animationBaseCollectionView.frame.width + 20
                self.selectColorCollectionView.frame.origin.x   = self.animationBaseCollectionView.frame.origin.x
            }
            
            isExpanded = true
        }
    }
    
    public func setupCollapsed() {
        self.expandButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
        
        self.frame.size.width = 90
        self.frame.origin.x   = (self.superview?.frame.width)! - self.frame.width
        
        self.viewWhole.frame.size.width = 70
        self.viewWhole.frame.origin.x   = 10
        
        self.selectColorCollectionView.frame.size.width = 60
        self.selectColorCollectionView.frame.origin.x   = 10
    }

    private func initalConfiguration() {
        expandButton.accessibilityIdentifier = "expandButton"
        
        viewWhole.layer.cornerRadius = 35
        viewWhole.isHidden           = false
        contentView.isHidden         = false
        
        selectColorCollectionView.reloadData()
    }
}
