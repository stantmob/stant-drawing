//
//  GroupEraseSizeView.swift
//  Pods-MyFirstDrawing
//
//  Created by Stant Macmini n04 on 25/07/19.
//

import UIKit
import Foundation

public class GroupEraseSizeView: GroupSizeView {
    public static let groupEraseSizeViewIdentifier = "groupEraseSizeView"
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(delegate: GroupSizeContract, bundle: Bundle, rootGroupView: CGFloat, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        super.init(groupSizeType: .erase, iconReferenceName: "eraserfull", buttonSizeImageName: "eraserSize", delegate: delegate, bundle: bundle, rootGroupView: rootGroupView, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        
        setIdentifierForView(view: self, identifierName: GroupEraseSizeView.groupEraseSizeViewIdentifier)
    }
}
