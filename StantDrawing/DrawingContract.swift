//
//  DrawingContract.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import Foundation

public protocol DrawingDelegate {
    func save(drawingImage: UIImage)
    func cancel()
}
