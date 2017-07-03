//
//  Drawing.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import Foundation

public class Drawing {
    public var delegate: DrawingDelegate?
    var drawingView: ACEDrawingView = ACEDrawingView.init()
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
        
        self.brushToolView = BrushToolView.instanceFromNib()
        var widthBase  = self.drawingFrame.width
        var heightBase = self.drawingFrame.height
        
        if isValid(image: placeholderImage) {
            widthBase  = placeholderImage.size.width
            heightBase = placeholderImage.size.height
        }
        
        let width  = widthBase - self.brushToolView.frame.width
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
        
        self.contentDrawing.addSubview(drawingView)
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
    
    // MARK: Private methods
    
    private func isValid(image: UIImage) -> Bool {
        return image.size.width > 0 && image.size.height > 0
    }
    
}


// MARK: Extension for BrushToolContract protocol
extension Drawing: BrushToolContract {
    func moveCanvas(){
        self.disableUserInteractionOnDrawingView()
    }
    
    func erase(){
        self.enableUserInteractionOnDrawingView()
        self.drawingView.drawTool = ACEDrawingToolTypeEraser
    }
    
    func draw(){
        self.enableUserInteractionOnDrawingView()
        drawingView.drawTool  = ACEDrawingToolTypePen
        drawingView.lineWidth = 10.0
        drawingView.lineAlpha = 0.5
        drawingView.lineColor = brushColor
    }
    
    func undo(){
        self.disableUserInteractionOnDrawingView()
        self.drawingView.undoLatestStep()
    }
    
    func redo(){
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
