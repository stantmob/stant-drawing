//
//  Drawing.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

public class Drawing {
    public var delegate: DrawingDelegate?
    var drawingView: ACEDrawingView = ACEDrawingView.init()
    let zoomScrollView: UIScrollView
    let contentDrawing: UIView
    let drawingFrame: CGRect
    let brushColor: UIColor
    let brushToolView: BrushToolView
    let placeholderImage: UIImage
    
    public init(contentDrawing: UIView, brushColor: UIColor, drawingImageToLoad: UIImage = UIImage(), placeholderImage: UIImage = UIImage()) {
        self.contentDrawing   = contentDrawing
        self.drawingFrame     = contentDrawing.frame
        self.brushColor       = brushColor
        self.placeholderImage = placeholderImage
        self.zoomScrollView   = UIScrollView.init(frame: self.drawingFrame)
        
        self.zoomScrollView.bouncesZoom = true
        
        self.brushToolView = BrushToolView.instanceFromNib()
        let widthBase  = self.drawingFrame.width
        let heightBase = self.drawingFrame.height
        
//        if isValid(image: placeholderImage) {
//            widthBase  = placeholderImage.size.width
//            heightBase = placeholderImage.size.height
//        }
        
        let width  = widthBase
//        let width  = widthBase - self.brushToolView.frame.width
        let height = heightBase
        let x      = self.drawingFrame.origin.x + self.brushToolView.frame.width
        let y      = self.drawingFrame.origin.y
        let frame = CGRect.init(x: x, y: y, width: width, height: height)
        
        self.drawingView = ACEDrawingView(frame: frame)
        
        if isValid(image: drawingImageToLoad) {
            self.drawingView.loadImage(drawingImageToLoad)
        }
        
        self.brushToolView.delegate = self
        
        if isValid(image: placeholderImage) {
           let imageView = UIImageView(image: placeholderImage)
            imageView.frame = frame
            self.contentDrawing.addSubview(imageView)
        }
        
        self.zoomScrollView.addSubview(drawingView)
        self.contentDrawing.addSubview(zoomScrollView)
        self.contentDrawing.addSubview(self.brushToolView)
        
        disableUserInteractionOnDrawingView()
    }
    
    
    // MARK: Enable/Disable UserInteraction on DrawingView
    
    func disableUserInteractionOnDrawingView() {
        self.drawingView.isUserInteractionEnabled = false
    }
    
    func enableUserInteractionOnDrawingView() {
        self.drawingView.isUserInteractionEnabled = true
    }
    
    // MARK: Stop/Start Drag and Scroll on ZoomScrollView
    
    func startDragAndScrollonZoomScrollView() {
        self.zoomScrollView.shouldStopDragAndScroll(false)
    }
    
    func stopDragAndScrollonZoomScrollView() {
        self.zoomScrollView.shouldStopDragAndScroll(true)
    }
    
    // MARK: Private methods
    
    private func isValid(image: UIImage) -> Bool {
        return image.size.width > 0 && image.size.height > 0
    }
    
}

extension UIScrollView {
    
    func shouldStopDragAndScroll(_ value: Bool) {
        self.panGestureRecognizer.isEnabled = value
        self.pinchGestureRecognizer!.isEnabled = value
    }
    
}


// MARK: Extension for BrushToolContract protocol
extension Drawing: BrushToolContract {
    func moveCanvas(){
        self.stopDragAndScrollonZoomScrollView()
        self.disableUserInteractionOnDrawingView()
    }
    
    func erase(){
        self.startDragAndScrollonZoomScrollView()
        self.enableUserInteractionOnDrawingView()
        self.drawingView.drawTool = ACEDrawingToolTypeEraser
    }
    
    func draw(){
        self.startDragAndScrollonZoomScrollView()
        self.enableUserInteractionOnDrawingView()
        drawingView.drawTool  = ACEDrawingToolTypePen
        drawingView.lineWidth = 10.0
        drawingView.lineAlpha = 0.5
        drawingView.lineColor = brushColor
    }
    
    func undo(){
        self.startDragAndScrollonZoomScrollView()
        self.disableUserInteractionOnDrawingView()
        self.drawingView.undoLatestStep()
    }
    
    func redo(){
        self.startDragAndScrollonZoomScrollView()
        self.disableUserInteractionOnDrawingView()
        self.drawingView.redoLatestStep()
    }
    
    func save(){
        let drawingImage = self.drawingView.image!
        delegate?.save(drawingImage: drawingImage)
    }
    
    func cancel(){
        delegate?.cancel()
    }
}
