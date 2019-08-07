//
//  DrawingView.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 29/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

public class DrawingView: UIView {
    internal let drawingDelegate: DrawingDelegate?
    
    internal let zoomScrollView:     UIScrollView   = UIScrollView()
    internal let contentDrawingView: ACEDrawingView = ACEDrawingView()
    internal let baseContentView:    UIView         = UIView()
    private  let brushToolView:      BrushToolView  = BrushToolView()
    
    private  var drawImage:                            UIImage
    private  let placeholderImage:                     UIImage
    private  let placeholderImageWithLowAlpha:         UIImage
    private  let alphaForPlaceholderImageWithLowAlpha: CGFloat
    private  var brushHexColor:                        String
    private  var message:                              String
    internal let brushColor:                           UIColor
    
    internal var pencilSize: CGFloat = 5.0
    internal var eraseSize: CGFloat  = 5.0
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame:                                CGRect,
                drawingDelegate:                      DrawingDelegate?,
                drawImage:                            UIImage,
                placeholderImage:                     UIImage,
                placeholderImageWithLowAlpha:         UIImage,
                alphaForPlaceholderImageWithLowAlpha: CGFloat,
                brushColor:                           UIColor,
                brushHexColor:                        String,
                message:                              String
        ) {
        self.drawingDelegate                      = drawingDelegate
        self.drawImage                            = drawImage
        self.placeholderImage                     = placeholderImage
        self.placeholderImageWithLowAlpha         = placeholderImageWithLowAlpha
        self.alphaForPlaceholderImageWithLowAlpha = alphaForPlaceholderImageWithLowAlpha
        self.brushColor                           = brushColor
        self.brushHexColor                        = brushHexColor
        self.message                              = message
        
        super.init(frame: frame)
        
        initialConfiguration()
        
        moveCanvas()
    }
    
    // MARK: Private methods
    
    private func initialConfiguration() {
        brushToolView.delegate = self
        
        configureZoomScrollView()
        baseContentView.frame = frameForContentDrawingView()
        
        configureContentDrawingView()
        configurePlaceholderImages()

        baseContentView.addSubview(contentDrawingView)

        
        zoomScrollView.addSubview(baseContentView)
        
        self.addSubview(zoomScrollView)
        self.addSubview(brushToolView)

        brushToolView.addAsSubViewOn(self, x: baseContentView.frame.width, heightBaseToCenter: baseContentView.frame.height)
    }
    
    private func configureZoomScrollView() {
        zoomScrollView.delegate = self
        
        zoomScrollView.frame       = frameForZoomScrollView()
        zoomScrollView.contentSize = frameForContentDrawingView().size
        
        zoomScrollView.bouncesZoom                    = true
        zoomScrollView.showsHorizontalScrollIndicator = false
        zoomScrollView.showsVerticalScrollIndicator   = false
        zoomScrollView.maximumZoomScale               = 14.0
        zoomScrollView.minimumZoomScale               = 1
    }
    
    private func configureContentDrawingView() {
        contentDrawingView.frame       = frameForContentDrawingView()
        
        if imageIsValid(drawImage) {
            let resizedImage = resizeImage(drawImage, size: contentDrawingView.frame.size)
            
            contentDrawingView.loadImage(resizedImage)
        }
    }
    
    private func configurePlaceholderImages() {
        if imageIsValid(placeholderImage) {
            let imageView = UIImageView(frame: frameForContentDrawingView())
            imageView.image = placeholderImage
            baseContentView.addSubview(imageView)
        }
        if imageIsValid(placeholderImageWithLowAlpha) {
            let imageView = UIImageView(frame: frameForContentDrawingView())
            imageView.image           = placeholderImageWithLowAlpha
            imageView.backgroundColor = UIColor.clear
            imageView.alpha           = alphaForPlaceholderImageWithLowAlpha
            baseContentView.addSubview(imageView)
        }
    }
    
    private func frameForZoomScrollView() -> CGRect {
        let x      = self.frame.origin.x + brushToolView.frame.width
        let y      = self.frame.origin.y
        let width  = self.frame.width - brushToolView.frame.width
        let height = self.frame.height
        
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
    
    private func frameForContentDrawingView() -> CGRect {
        let x      = self.frame.origin.x
        let y      = self.frame.origin.y
        let width  = self.frame.width - brushToolView.frame.width
        let height = self.frame.height
        
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
    
    
    // MARK: Image Utils
    private func imageIsValid(_ image: UIImage) -> Bool {
        return image.size.width > 0 && image.size.height > 0
    }
    
    private func resizeImage(_ image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

// MARK: Enable/Disable UserInteraction on ContentDrawingView
extension DrawingView {
    internal func disableUserInteractionOnContentDrawingView() {
        contentDrawingView.isUserInteractionEnabled = false
    }
    
    internal func enableUserInteractionOnContentDrawingView() {
        contentDrawingView.isUserInteractionEnabled = true
    }
}

// MARK: Stop/Start Drag and Scroll on ZoomScrollView
//       Enable/Disable UserInteraction on ZoomScrollView
extension DrawingView {
    internal func startDragAndScrollOnZoomScrollView() {
        zoomScrollView.panGestureRecognizer.isEnabled    = true
        zoomScrollView.pinchGestureRecognizer?.isEnabled = true
    }
    
    internal func stopDragAndScrollOnZoomScrollView() {
        zoomScrollView.panGestureRecognizer.isEnabled    = false
        zoomScrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    internal func disableUserInteractionOnZoomScrollView() {
        zoomScrollView.isUserInteractionEnabled = false
    }
    
    internal func enableUserInteractionOnZoomScrollView() {
        zoomScrollView.isUserInteractionEnabled = true
    }
}

// MARK: Extension for BrushToolContract protocol
extension DrawingView: BrushToolContract {
    
    public func moveCanvas() {
        startDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        disableUserInteractionOnContentDrawingView()
    }
    
    public func erase() {
        contentDrawingView.drawTool  = ACEDrawingToolTypeEraser
        contentDrawingView.lineWidth = eraseSize
        
        stopDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        enableUserInteractionOnContentDrawingView()
    }
    
    public func draw() {
        contentDrawingView.drawTool  = ACEDrawingToolTypePen
        contentDrawingView.lineWidth = pencilSize
        contentDrawingView.lineAlpha = 0.5
        contentDrawingView.lineColor = UIColor(hex: brushHexColor)
        
        if let contentDrawing = contentDrawingView.image {
            drawImage = contentDrawing
        }
        
        stopDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        enableUserInteractionOnContentDrawingView()
    }
    
    public func undo() {
        contentDrawingView.undoLatestStep()
    }
    
    public func redo() {
        contentDrawingView.redoLatestStep()
    }
    
    public func changePencilSize(_ size: CGFloat) {
        pencilSize = size
        contentDrawingView.lineWidth = pencilSize
    }
    
    public func changeEraserSize(_ size: CGFloat) {
        eraseSize = size
        contentDrawingView.lineWidth = eraseSize
    }
    
    public func changeColor(_ color: String) {
                                
        self.brushHexColor                = color
        self.contentDrawingView.lineColor = UIColor(hex: color)
        
        stopDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        disableUserInteractionOnContentDrawingView()
        
        drawImage = UIImage()
        
        contentDrawingView.loadImage(drawImage)
        brushToolView.groupToolsButtons.last?.uiButton.tintColor = UIColor(hex: color)
    }
    
    public func getMessage() -> String {
        return self.message
    }
    
    public func getHexColor() -> String {
        return brushHexColor
    }
    
    public func haveDrawingImage() -> Bool {
        if let contentDrawing = contentDrawingView.image {
            return imageIsValid(contentDrawing)
        }        
        return imageIsValid(drawImage)
    }
    
    public func save() {
        if let delegate = drawingDelegate {
            guard let drawingImage = contentDrawingView.image else {
                self.drawingDelegate?.saveWithoutChanges()
                return
            }
            delegate.save(drawingImage: drawingImage, drawingColor: brushHexColor)
        }
    }
    
    public func cancel(){
        if let delegate = drawingDelegate {
            delegate.cancel()
        }
    }
}

// MARK: Extension for UIScrollViewDelegate protocol
extension DrawingView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return baseContentView
    }
}
