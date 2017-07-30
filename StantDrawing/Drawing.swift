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
//
//func main() {
//    let main = UIView.init()
//    let drawingView = DrawingViewBuilder()
//        .brushColor(UIColor.red)
//        .loadDrawImage(UIImage())
//        .containerDrawingViewFrame(CGRect(x: 0, y: 0, width: 100, height: 100))
//        .build()
//    
//    main.addSubview(drawingView)
//    
//}
//
//public class Drawing {
//    public var delegate: DrawingDelegate?
//    var drawingView: ACEDrawingView = ACEDrawingView.init()
//    let zoomScrollView: UIScrollView
//    let contentDrawing: UIView
//    let drawingFrame: CGRect
//    let brushColor: UIColor
//    let brushToolView: BrushToolView
//    let placeholderImage: UIImage
//
//    public init(contentDrawing: UIView,
//      brushColor: UIColor,
//        drawingImageToLoad: UIImage = UIImage(),
//          placeholderImage: UIImage = UIImage()) {
//        self.contentDrawing   = contentDrawing
//        self.drawingFrame     = contentDrawing.frame
//        self.brushColor       = brushColor
//        self.placeholderImage = placeholderImage
//
//
//        let frameA = CGRect.init(x: 0, y: 0, width: 60, height: 900)
//        let a = BrushToolView.init(frame:  frameA)
////        self.brushToolView = BrushToolView.instanceFromNib(view: contentDrawing)
//        self.brushToolView = a
//        let widthBase  = self.drawingFrame.width
//        let heightBase = self.drawingFrame.height
//
////        if isValid(image: placeholderImage) {
////            widthBase  = placeholderImage.size.width
////            heightBase = placeholderImage.size.height
////        }
//
//        let width  = widthBase
////        let width  = widthBase - self.brushToolView.frame.width
//        let height = heightBase
//        let x      = self.drawingFrame.origin.x + self.brushToolView.frame.width
//        let y      = self.drawingFrame.origin.y
//        let frame = CGRect.init(x: x, y: y, width: width, height: height)
//
//        self.zoomScrollView   = UIScrollView.init(frame: frame)
////        self.zoomScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.zoomScrollView.bouncesZoom = true
//        self.zoomScrollView.contentMode = .scaleToFill
//
//        var truckDrawingFrame = CGRect.init(x: 0, y: 0, width: placeholderImage.size.width, height: placeholderImage.size.height)
//
//        if isValid(image: placeholderImage) == false {
//            truckDrawingFrame = frame
//        }
//
//        self.drawingView = ACEDrawingView(frame: truckDrawingFrame)
//        self.drawingView.contentMode = .scaleAspectFit
//        if isValid(image: drawingImageToLoad) {
//            self.drawingView.loadImage(drawingImageToLoad)
//        }
//
//        self.brushToolView.delegate = self
//
//        if isValid(image: placeholderImage) {
//           let imageView = UIImageView(image: placeholderImage)
//
//            imageView.frame = truckDrawingFrame
//
//            imageView.contentMode = .scaleAspectFit
////            self.contentDrawing.addSubview(imageView)
//            self.zoomScrollView.addSubview(imageView)
//        }
//
//        self.zoomScrollView.addSubview(drawingView)
//        self.contentDrawing.addSubview(zoomScrollView)
//        self.contentDrawing.addSubview(brushToolView)
//
//        moveCanvas()
//    }
//
//
//    // MARK: Enable/Disable UserInteraction on DrawingView
//
//    func disableUserInteractionOnDrawingView() {
//        self.drawingView.isUserInteractionEnabled = false
//    }
//
//    func enableUserInteractionOnDrawingView() {
//        self.drawingView.isUserInteractionEnabled = true
//    }
//
//    // MARK: Stop/Start Drag and Scroll on ZoomScrollView
//
//    func startDragAndScrollonZoomScrollView() {
//        self.zoomScrollView.shouldStopDragAndScroll(false)
//    }
//
//    func stopDragAndScrollonZoomScrollView() {
//        self.zoomScrollView.shouldStopDragAndScroll(true)
//    }
//
//    // MARK: Private methods
//
//    private func isValid(image: UIImage) -> Bool {
//        return image.size.width > 0 && image.size.height > 0
//    }
//
//}
//
////extension Drawing: UIScrollViewDelegate {
////    public func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
////        return self.drawingView
////    }
////}
//
//extension UIScrollView {
//
//    func shouldStopDragAndScroll(_ value: Bool) {
////        self.panGestureRecognizer.isEnabled = value
////        self.pinchGestureRecognizer!.isEnabled = value
//    }
//
//}
//
//
//// MARK: Extension for BrushToolContract protocol
//extension Drawing: BrushToolContract {
//    func moveCanvas(){
//        self.stopDragAndScrollonZoomScrollView()
//        self.disableUserInteractionOnDrawingView()
//    }
//
//    func erase(){
//        self.startDragAndScrollonZoomScrollView()
//        self.enableUserInteractionOnDrawingView()
//        self.drawingView.drawTool = ACEDrawingToolTypeEraser
//    }
//
//    func draw(){
//        self.startDragAndScrollonZoomScrollView()
//        self.enableUserInteractionOnDrawingView()
//        drawingView.drawTool  = ACEDrawingToolTypePen
//        drawingView.lineWidth = 10.0
//        drawingView.lineAlpha = 0.5
//        drawingView.lineColor = brushColor
//    }
//
//    func undo(){
//        self.startDragAndScrollonZoomScrollView()
//        self.disableUserInteractionOnDrawingView()
//        self.drawingView.undoLatestStep()
//    }
//
//    func redo(){
//        self.startDragAndScrollonZoomScrollView()
//        self.disableUserInteractionOnDrawingView()
//        self.drawingView.redoLatestStep()
//    }
//
//    func save(){
//        let drawingImage = self.drawingView.image!
//        delegate?.save(drawingImage: drawingImage)
//    }
//
//    func cancel(){
//        delegate?.cancel()
//    }
//}
//
//
///// -------------------------------------------
//
////
////  Drawing.swift
////  StantDrawing
////
////  Created by Rachid Calazans on 03/07/17.
////  Copyright Â© 2017 Stant. All rights reserved.
////
//
//import UIKit
//import Foundation
//import SystemConfiguration
//
//public class Drawing2 {
//    public var delegate: DrawingDelegate?
//    public var viewController: UIViewController?
//    var drawingView: ACEDrawingView
//    let baseView: UIView
//    let zoomScrollView: UIScrollView
//    let contentDrawing: UIView
//    let drawingFrame: CGRect
//    let brushColor: UIColor
//    let brushToolView: BrushToolView
//    let placeholderImage: UIImage
//    let placeDrawingImage: UIImage
//
//    public init(contentDrawing: UIView,
//      brushColor: UIColor,
//      drawingImageToLoad: UIImage = UIImage(),
//      placeholderImage: UIImage = UIImage(),
//      placeDrawingImage: UIImage = UIImage()) {
//        self.contentDrawing   = contentDrawing
//        self.drawingFrame     = contentDrawing.frame
//        self.brushColor       = brushColor
//        self.placeholderImage = placeholderImage
//        self.placeDrawingImage = placeDrawingImage
//
//        self.brushToolView = BrushToolView.instanceFromNib()
//
//        var x      = self.drawingFrame.origin.x + self.brushToolView.frame.width
//        let y      = self.drawingFrame.origin.y
//        let width  = self.drawingFrame.width - self.brushToolView.frame.width
//        let height = self.drawingFrame.height
//
//        let frameForScrollView = CGRect.init(x: x, y: y, width: width, height: height)
//
//        x = self.drawingFrame.origin.x
//        let frameScrollViewContent = CGRect.init(x: x, y: y, width: width, height: height)
//
////        let frameForDrawing = CGRect.init(x: x, y: y, width: placeholderImage.size.width, height: placeholderImage.size.height)
////        self.drawingView      = ACEDrawingView(frame: frameForDrawing)
//        self.drawingView      = ACEDrawingView(frame: frameScrollViewContent)
//        self.baseView         = UIView.init(frame: frameScrollViewContent)
//        self.zoomScrollView   = UIScrollView.init(frame: frameForScrollView)
//
//        self.zoomScrollView.bouncesZoom = true
//        self.zoomScrollView.showsHorizontalScrollIndicator = false
//        self.zoomScrollView.showsVerticalScrollIndicator   = false
//        self.zoomScrollView.maximumZoomScale = 14.0
//        self.zoomScrollView.minimumZoomScale = 1
//        self.zoomScrollView.contentSize = frameScrollViewContent.size
//
//        if isValid(image: placeholderImage) == false {
////            let newDrawingImageToLoad = UIImage()
////            newDrawingImageToLoad.size = placeholderImage.size
////            self.drawingView.loadImage(newDrawingImageToLoad)
//        }
//
//        if isValid(image: drawingImageToLoad) {
////            self.drawingView.frame = frameForDrawing
//
//            let imageResized = resizeImage(image: drawingImageToLoad,
//                                           width: self.drawingView.frame.width,
//                                           height:self.drawingView.frame.height)
//
//
//            self.drawingView.frame = frameScrollViewContent
//            self.drawingView.loadImage(imageResized)
//            self.drawingView.contentMode = .scaleAspectFit
//        } else {
//            self.drawingView.frame = frameScrollViewContent
//            self.drawingView.contentMode = .scaleAspectFit
//        }
//
//        self.brushToolView.delegate = self
//
//        if isValid(image: placeholderImage) {
//            let imageView = UIImageView(frame: frameScrollViewContent)
//            imageView.image = placeholderImage
//
//            self.baseView.addSubview(imageView)
//
//            let placeDrawing = UIImageView(frame: frameScrollViewContent)
//            placeDrawing.image = placeDrawingImage
//
//            placeDrawing.backgroundColor = UIColor.clear
//            placeDrawing.alpha = 0.5
////            placeDrawing.contentMode = .scaleAspectFit
//            self.baseView.addSubview(placeDrawing)
//        }
//
//        self.baseView.addSubview(drawingView)
//
//        baseView.contentMode = .scaleAspectFit
//
//        self.zoomScrollView.addSubview(baseView)
//        self.contentDrawing.addSubview(zoomScrollView)
//        self.contentDrawing.addSubview(brushToolView)
//
//        moveCanvas()
//    }
//
//    // MARK: Enable/Disable UserInteraction on DrawingView
//
//    func disableUserInteractionOnDrawingView() {
////        self.zoomScrollView.isUserInteractionEnabled = false
//        self.drawingView.isUserInteractionEnabled = false
//    }
//
//    func enableUserInteractionOnDrawingView() {
////        self.zoomScrollView.isUserInteractionEnabled = true
//        self.drawingView.isUserInteractionEnabled = true
//    }
//
//    // MARK: Stop/Start Drag and Scroll on ZoomScrollView
//
//    func startDragAndScrollonZoomScrollView() {
//        self.zoomScrollView.panGestureRecognizer.isEnabled = true
//        self.zoomScrollView.pinchGestureRecognizer?.isEnabled = true
////        self.zoomScrollView.shouldStopDragAndScroll(true)
//    }
//
//    func stopDragAndScrollonZoomScrollView() {
//        self.zoomScrollView.panGestureRecognizer.isEnabled = false
//        self.zoomScrollView.pinchGestureRecognizer?.isEnabled = false
////        self.zoomScrollView.shouldStopDragAndScroll(false)
//    }
//
//    // MARK: Private methods
//
//    private func isValid(image: UIImage) -> Bool {
//        return image.size.width > 0 && image.size.height > 0
//    }
//
//    private func resizeImage(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage? {
//
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }
//
//}
//
////extension Drawing: UIScrollViewDelegate {
////    public func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
////        return self.drawingView
////    }
////}
//
//
//// MARK: Extension for BrushToolContract protocol
//extension Drawing2: BrushToolContract {
//    func moveCanvas(){
//        self.zoomScrollView.panGestureRecognizer.isEnabled = true
//        self.zoomScrollView.pinchGestureRecognizer?.isEnabled = true
//        self.zoomScrollView.isUserInteractionEnabled = true
//        self.disableUserInteractionOnDrawingView()
////        self.startDragAndScrollonZoomScrollView()
//    }
//
//    func erase(){
//        self.zoomScrollView.panGestureRecognizer.isEnabled = false
//        self.zoomScrollView.pinchGestureRecognizer?.isEnabled = false
//        self.zoomScrollView.isUserInteractionEnabled = true
//
////        self.startDragAndScrollonZoomScrollView()
//        self.enableUserInteractionOnDrawingView()
//        self.drawingView.drawTool = ACEDrawingToolTypeEraser
//        drawingView.lineWidth = 10.0
//    }
//
//    func draw(){
//        self.zoomScrollView.panGestureRecognizer.isEnabled = false
//        self.zoomScrollView.pinchGestureRecognizer?.isEnabled = false
//        self.zoomScrollView.isUserInteractionEnabled = true
//
////        self.startDragAndScrollonZoomScrollView()
//        self.enableUserInteractionOnDrawingView()
//        drawingView.drawTool  = ACEDrawingToolTypePen
//        drawingView.lineWidth = 10.0
//        drawingView.lineAlpha = 0.5
//        drawingView.lineColor = brushColor
//    }
//
//    func undo(){
////        self.startDragAndScrollonZoomScrollView()
////        self.disableUserInteractionOnDrawingView()
//        self.drawingView.undoLatestStep()
//    }
//
//    func redo(){
////        self.startDragAndScrollonZoomScrollView()
////        self.disableUserInteractionOnDrawingView()
//        self.drawingView.redoLatestStep()
//    }
//
//    func save(){
//        let drawingImage = self.drawingView.image!
//        delegate?.save(drawingImage: drawingImage)
//    }
//
//    func cancel(){
//        delegate?.cancel()
//    }
//}
