//
//  GroupPencilSizeView.swift
//  Pods-MyFirstDrawing
//
//  Created by Stant Macmini n04 on 25/07/19.
//

import UIKit
import Foundation

public class GroupPencilSizeView: GroupSizeView {
    public static let groupPencilSizeViewIdentifier = "groupPencilSizeView"

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(groupSizeType: .pencil, iconReferenceName: "pencil", buttonSizeImageName: "pencilSize")
        
        setIdentifierForView(view: self, identifierName: GroupPencilSizeView.groupPencilSizeViewIdentifier)
    }
}
