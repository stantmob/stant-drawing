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
    @IBOutlet weak var expandButton: UIButton!
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
    

    @IBAction func expandDidTapped(_ sender: Any) {
        
        if isExpanded {
            
            UIView.animate(withDuration: 0.5) {
                self.expandButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
//                self.contentView.frame = CGRect(x: self.contentView.frame.origin.x,
//                                                y: self.contentView.frame.origin.y,
//                                                width: 90,
//                                                height: self.contentView.frame.height)
//                self.contentView.frame.size.width = self.contentView.frame.width
            }
            
            print("clicked expanded")
            isExpanded = false
            
        } else {

            UIView.animate(withDuration: 0.5) {
                self.expandButton.imageView?.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                
//                self.contentView.frame.origin = CGPoint(x: contentView.frame.origin.x + 30, y: y)
//                self.contentView.frame.size.width = 450
            }
            
            print("clicked collapsed")
            
            isExpanded = true
        }
    }
    
    public func showSelectColorGroup() {
        self.contentView.isHidden = false
    }
    
    public func hideSelectColorGroup() {
        self.contentView.isHidden = true
    }
    
    private func initalConfiguration() {
        viewWhole.layer.cornerRadius = 35
    }
}
