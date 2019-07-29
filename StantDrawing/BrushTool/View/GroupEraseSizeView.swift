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
    
    init() {
        super.init(groupSizeType: .erase, iconReferenceName: "eraserfull", buttonSizeImageName: "eraserSize")
        
        setIdentifierForView(view: self, identifierName: GroupEraseSizeView.groupEraseSizeViewIdentifier)
    }
}
