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
    
    private let btnWidth  = 60
    private let btnHeight = 60
    
    private let moveBtn   = UIButton()
    private let brushBtn  = UIButton()
    private let undoBtn   = UIButton()
    private let redoBtn   = UIButton()
    private let eraseBtn  = UIButton()
    private let saveBtn   = UIButton()
    private let cancelBtn = UIButton()
    
//    public class func instanceFromNib() -> BrushToolView {
//        let podBundle = Bundle(for: BrushToolView.self)
//        
//        let bundleURL = podBundle.url(forResource: "StantDrawing", withExtension: "bundle")
//        let bundle = Bundle(url: bundleURL!)
//        return UINib(nibName: "BrushToolView", bundle: bundle)
//        .instantiate(withOwner: BrushToolView.init(), options: nil)[0] as! BrushToolView
//    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let screenSize = UIScreen.main.bounds
        let frame      = CGRect(x: 0, y: 0, width: 60, height: screenSize.height)

        super.init(frame: frame)

        self.backgroundColor = UIColor.gray
        
        configureButtons()
    }
    
    private func nextBtnFrame(referencedBtn: UIButton) -> CGRect {
        return CGRect(x: 0, y: Int(referencedBtn.frame.origin.y + 75), width: btnWidth, height: btnHeight)
    }
    
    private func configureButtons() {
        moveBtn.frame   = CGRect(x: 0, y: 30, width: btnWidth, height: btnHeight)
        brushBtn.frame  = nextBtnFrame(referencedBtn: moveBtn)
        undoBtn.frame   = nextBtnFrame(referencedBtn: brushBtn)
        redoBtn.frame   = nextBtnFrame(referencedBtn: undoBtn)
        eraseBtn.frame  = nextBtnFrame(referencedBtn: redoBtn)
        saveBtn.frame   = nextBtnFrame(referencedBtn: eraseBtn)
        cancelBtn.frame = nextBtnFrame(referencedBtn: saveBtn)
        
        let bundle = Bundle(for: BrushToolView.self)
        
        moveBtn.setTitle("Move", for: .normal)
        let moveImg = UIImage.init(named: "move", in: bundle, compatibleWith: nil)
        moveBtn.setImage(moveImg, for: .normal)
//        moveBtn.setImage(UIImage.init(named: "move"), for: .normal)
        
        brushBtn.setTitle("Brush", for: .normal)
        undoBtn.setTitle("Undo", for: .normal)
        redoBtn.setTitle("Redo", for: .normal)
        eraseBtn.setTitle("Erase", for: .normal)
        saveBtn.setTitle("Save", for: .normal)
        cancelBtn.setTitle("Cancel", for: .normal)
        
        moveBtn.backgroundColor = UIColor.blue
        eraseBtn.backgroundColor = UIColor.orange
        cancelBtn.backgroundColor = UIColor.purple
        
        moveBtn.addTarget(self, action: #selector(self.moveCanvas), for: .touchUpInside)
        brushBtn.addTarget(self, action: #selector(self.drawOnCanvas), for: .touchUpInside)
        undoBtn.addTarget(self, action: #selector(self.undo), for: .touchUpInside)
        redoBtn.addTarget(self, action: #selector(self.redo), for: .touchUpInside)
        eraseBtn.addTarget(self, action: #selector(self.erase), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(self.cancel), for: .touchUpInside)
        
        self.addSubview(moveBtn)
        self.addSubview(brushBtn)
        self.addSubview(undoBtn)
        self.addSubview(redoBtn)
        self.addSubview(eraseBtn)
        self.addSubview(saveBtn)
        self.addSubview(cancelBtn)
    }
    
    // MARK: IBActions
    
    func moveCanvas(_ sender: Any) {
        self.delegate?.moveCanvas()
    }
    
    func erase(_ sender: Any) {
        self.delegate?.erase()
    }
    
    func drawOnCanvas(_ sender: Any) {
        delegate?.draw()
    }
    
    func undo(_ sender: Any) {
        self.delegate?.undo()
    }
    
    func redo(_ sender: Any) {
        self.delegate?.redo()
    }
    
    func save(_ sender: Any) {
        let alert = UIAlertController(title: "Salvar", message: "Deseja salvar as alterações e sair do modo de seleção?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.save()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
    
    func cancel(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja cancelar a edição? Todas alterações serão perdidas", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.cancel()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
}

