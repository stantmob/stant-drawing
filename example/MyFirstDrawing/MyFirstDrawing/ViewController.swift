//
//  ViewController.swift
//  MyFirstDrawing
//
//  Created by Stant 02 on 02/02/18.
//  Copyright © 2018 Stant 02. All rights reserved.
//

import UIKit
import StantDrawing

class ViewController: UIViewController {

    @IBOutlet weak var viewToDraw: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawingView = DrawingViewBuilder()
            .delegate(self)
            .containerDrawingViewFrame(viewToDraw.frame)
            .build()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(drawingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: DrawingDelegate {
    func save(drawingImage: UIImage, drawingColor: String) {
        print("Saved with drawingColor")
    }
    
    func saveWithoutChanges() {
        print("Saved without changes")
    }
    
    func save(drawingImage: UIImage) {
        print("Saved")
    }
    
    func cancel() {
        print("Cancel")
    }
}
