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
    
    private  let drawImage:                            UIImage
    private  let placeholderImage:                     UIImage
    private  let placeholderImageWithLowAlpha:         UIImage
    private  let alphaForPlaceholderImageWithLowAlpha: CGFloat
    internal let brushColor:                           UIColor
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame:                                CGRect,
                drawingDelegate:                      DrawingDelegate?,
                drawImage:                            UIImage,
                placeholderImage:                     UIImage,
                placeholderImageWithLowAlpha:         UIImage,
                alphaForPlaceholderImageWithLowAlpha: CGFloat,
                brushColor:                           UIColor
        ) {
        self.drawingDelegate                      = drawingDelegate
        self.drawImage                            = drawImage
        self.placeholderImage                     = placeholderImage
        self.placeholderImageWithLowAlpha         = placeholderImageWithLowAlpha
        self.alphaForPlaceholderImageWithLowAlpha = alphaForPlaceholderImageWithLowAlpha
        self.brushColor                           = brushColor
        
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
        baseContentView.contentMode = .scaleAspectFit
        
        zoomScrollView.addSubview(baseContentView)
        self.addSubview(zoomScrollView)
        self.addSubview(brushToolView)
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
        contentDrawingView.contentMode = .scaleAspectFit
        
        if imageIsValid(drawImage) {
            let resizedImage = resizeImage(drawImage, size: frameForContentDrawingView().size)
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
    func moveCanvas() {
        startDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        disableUserInteractionOnContentDrawingView()
    }
    
    func erase() {
        contentDrawingView.drawTool  = ACEDrawingToolTypeEraser
        contentDrawingView.lineWidth = 10.0
        
        stopDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        enableUserInteractionOnContentDrawingView()
    }
    
    func draw() {
        contentDrawingView.drawTool  = ACEDrawingToolTypePen
        contentDrawingView.lineWidth = 10.0
        contentDrawingView.lineAlpha = 0.5
        contentDrawingView.lineColor = brushColor
        
        stopDragAndScrollOnZoomScrollView()
        enableUserInteractionOnZoomScrollView()
        enableUserInteractionOnContentDrawingView()
    }
    
    func undo() {
        contentDrawingView.undoLatestStep()
    }
    
    func redo() {
        contentDrawingView.redoLatestStep()
    }
    
    func save() {
        if let delegate = drawingDelegate {
            let drawingImage = contentDrawingView.image!
            delegate.save(drawingImage: drawingImage)
        }
    }
    
    func cancel(){
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
