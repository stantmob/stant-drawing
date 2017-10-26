//
//  DrawingViewBuilder.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 29/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

public class DrawingViewBuilder {
    internal var drawingDelegate: DrawingDelegate?
    internal var brushColor:                           UIColor = UIColor.black
    private  var containerDrawingViewFrame:            CGRect
    private  var drawImage:                            UIImage = UIImage()
    private  var placeholderImage:                     UIImage = UIImage()
    private  var placeholderImageWithLowAlpha:         UIImage = UIImage()
    private  var alphaForPlaceholderImageWithLowAlpha: CGFloat = 0.5
    
    public init() {
        let screenSize = UIScreen.main.bounds
        containerDrawingViewFrame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
    }
    
    public func delegate(_ delegate: DrawingDelegate) -> DrawingViewBuilder {
        drawingDelegate = delegate
        return self
    }
    
    public func brushColor(_ color: UIColor) -> DrawingViewBuilder {
        brushColor = color
        return self
    }
    
    public func loadDrawImage(_ image: UIImage) -> DrawingViewBuilder {
        drawImage = image
        return self
    }
    
    public func placeholderImage(_ image: UIImage) -> DrawingViewBuilder {
        placeholderImage = image
        return self
    }
    
    public func placeholderImageWithLowAlpha(_ image: UIImage, alpha: CGFloat = 0.5) -> DrawingViewBuilder {
        placeholderImageWithLowAlpha         = image
        alphaForPlaceholderImageWithLowAlpha = alpha
        return self
    }
    
    public func containerDrawingViewFrame(_ frame: CGRect) -> DrawingViewBuilder {
        containerDrawingViewFrame = frame
        return self
    }
    
    public func build() -> DrawingView {
        return DrawingView.init(frame:                                containerDrawingViewFrame,
                                drawingDelegate:                      drawingDelegate,
                                drawImage:                            drawImage,
                                placeholderImage:                     placeholderImage,
                                placeholderImageWithLowAlpha:         placeholderImageWithLowAlpha,
                                alphaForPlaceholderImageWithLowAlpha: alphaForPlaceholderImageWithLowAlpha,
                                brushColor:                           brushColor
        )
    }
   
}

