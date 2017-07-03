//
//  BrushView.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import UIKit
import Foundation

public class BrushToolView: UIView {
    var delegate: BrushToolContract?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> BrushToolView {
        let podBundle = Bundle(for: BrushToolView.self)
        
        let bundleURL = podBundle.url(forResource: "StantDrawing", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        
        let nib = UINib(nibName: "BrushToolView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0]
        
        return nib as! BrushToolView
    }
    
    // MARK: IBActions
    
    @IBAction func moveCanvas(_ sender: Any) {
        self.delegate?.moveCanvas()
    }
    
    @IBAction func erase(_ sender: Any) {
        self.delegate?.erase()
    }
    
    @IBAction func draw(_ sender: Any) {
        delegate?.draw()
    }
    
    @IBAction func undo(_ sender: Any) {
        self.delegate?.undo()
    }
    
    @IBAction func redo(_ sender: Any) {
        self.delegate?.redo()
    }
    
    @IBAction func save(_ sender: Any) {
        let alert = UIAlertController(title: "Salvar", message: "Deseja salvar as alterações e sair do modo de seleção?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.save()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja cancelar a edição? Todas alterações serão perdidas", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.cancel()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
}

