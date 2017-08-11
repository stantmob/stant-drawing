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
    
    private let bundle = Bundle(for: BrushToolView.self)
    
    private let btnWidth  = 45
    private let btnHeight = 45
    
    private let groupToolsView = UIView()
    private let separatorView  = UIView()
    private let groupEndView   = UIView()
    
    private let moveBtn   = UIButton()
    private let brushBtn  = UIButton()
    private let undoBtn   = UIButton()
    private let redoBtn   = UIButton()
    private let eraseBtn  = UIButton()
    private let saveBtn   = UIButton()
    private let cancelBtn = UIButton()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let screenSize = UIScreen.main.bounds
        let frame      = CGRect(x: 10, y: 0, width: 85, height: screenSize.height)

        super.init(frame: frame)
        
        configureLayout()
        addBtnListeners()
        
        setBtnAsClicked(button: moveBtn)
    }
    
    private func configureLayout() {
        configureBtnPositions()
        configureBtnIcons()
        setAllBtnsAsNotClicked()

        configureGroupViews()
        
        addSubViews()
    }
    
    private func configureBtnPositions() {
        let x = (Int(self.frame.width) - btnWidth) / 2
        let frame = CGRect(x: x, y: 20, width: btnWidth, height: btnHeight)
        
        moveBtn.frame   = frame
        brushBtn.frame  = nextBtnFrame(referencedBtn: moveBtn)
        undoBtn.frame   = nextBtnFrame(referencedBtn: brushBtn)
        redoBtn.frame   = nextBtnFrame(referencedBtn: undoBtn)
        eraseBtn.frame  = nextBtnFrame(referencedBtn: redoBtn)
        
        saveBtn.frame   = frame
        cancelBtn.frame = nextBtnFrame(referencedBtn: saveBtn)
        
        setImageEdgeInsets(btn: moveBtn)
        setImageEdgeInsets(btn: brushBtn)
        setImageEdgeInsets(btn: undoBtn)
        setImageEdgeInsets(btn: redoBtn)
        setImageEdgeInsets(btn: eraseBtn)
        setImageEdgeInsets(btn: saveBtn)
        setImageEdgeInsets(btn: cancelBtn)
    }
    
    private func nextBtnFrame(referencedBtn: UIButton) -> CGRect {
        let x = (Int(self.frame.width) - btnWidth) / 2
        return CGRect(x: x, y: Int(referencedBtn.frame.origin.y + 75), width: btnWidth, height: btnHeight)
    }
    
    private func setImageEdgeInsets(btn: UIButton) {
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func configureBtnIcons() {
        setBtnImage(btn: moveBtn,   imageName: "move")
        setBtnImage(btn: brushBtn,  imageName: "paint-brush")
        setBtnImage(btn: undoBtn,   imageName: "undo")
        setBtnImage(btn: redoBtn,   imageName: "redo")
        setBtnImage(btn: eraseBtn,  imageName: "eraser")
        setBtnImage(btn: saveBtn,   imageName: "save")
        setBtnImage(btn: cancelBtn, imageName: "cancel")
    }

    private func setBtnImage(btn: UIButton, imageName: String) {
        let image = UIImage.init(named: imageName, in: bundle, compatibleWith: nil)
        btn.setImage(image, for: .normal)
    }
    
    private func addBtnListeners() {
        addBtnListener(moveBtn,   action: #selector(self.moveCanvas))
        addBtnListener(brushBtn,  action: #selector(self.drawOnCanvas))
        addBtnListener(undoBtn,   action: #selector(self.undo))
        addBtnListener(redoBtn,   action: #selector(self.redo))
        addBtnListener(eraseBtn,  action: #selector(self.erase))
        addBtnListener(saveBtn,   action: #selector(self.save))
        addBtnListener(cancelBtn, action: #selector(self.cancel))
    }
    
    private func addBtnListener(_ btn: UIButton, action: Selector) {
        btn.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func configureGroupViews() {
        let origin = CGPoint(x: 0, y: 100)
        let size   = CGSize(width: self.frame.size.width, height: eraseBtn.frame.origin.y + eraseBtn.frame.height + 20)
        let frame = CGRect.init(origin: origin, size: size)
        groupToolsView.frame = frame
        
        groupToolsView.backgroundColor = UIColor(hex: "F0F0F0")
        
        let origin2 = CGPoint(x: 20, y: groupToolsView.frame.origin.y + groupToolsView.frame.height + 10)
        let size2 = CGSize(width: self.frame.width - 40, height: 1)
        let frame2 = CGRect.init(origin: origin2, size: size2)
        separatorView.frame = frame2
        
        separatorView.backgroundColor = UIColor.black
        separatorView.alpha = 0.2
        
        let origin3 = CGPoint(x: 0, y: frame2.height + frame2.origin.y + 10)
        let size3 = CGSize(width: self.frame.size.width, height: cancelBtn.frame.origin.y + cancelBtn.frame.height + 20)
        let frame3 = CGRect.init(origin: origin3, size: size3)
        groupEndView.frame = frame3
        
        groupEndView.backgroundColor = UIColor(hex: "F0F0F0")
        
        groupToolsView.layer.cornerRadius = groupToolsView.frame.width / 2
        
        groupEndView.layer.cornerRadius = groupEndView.frame.width / 2

    }

    private func addSubViews() {
        self.addSubview(groupToolsView)
        self.addSubview(separatorView)
        self.addSubview(groupEndView)
        
        groupToolsView.addSubview(moveBtn)
        groupToolsView.addSubview(brushBtn)
        groupToolsView.addSubview(undoBtn)
        groupToolsView.addSubview(redoBtn)
        groupToolsView.addSubview(eraseBtn)
        
        groupEndView.addSubview(saveBtn)
        groupEndView.addSubview(cancelBtn)
    }
    
    private func setBtnAsClicked(button: UIButton) {
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = UIColor.white
    }
    
    private func setAllBtnsAsNotClicked() {
        setBtnAsNotClicked(button: self.moveBtn)
        setBtnAsNotClicked(button: self.eraseBtn)
        setBtnAsNotClicked(button: self.brushBtn)
        setBtnAsNotClicked(button: self.undoBtn)
        setBtnAsNotClicked(button: self.redoBtn)
    }
    
    private func setBtnAsNotClicked(button: UIButton) {
        button.alpha = 0.4
        button.backgroundColor = UIColor.clear
    }
    
    // MARK: IBActions
    
    func moveCanvas(_ sender: Any) {
        setAllBtnsAsNotClicked()
        setBtnAsClicked(button: self.moveBtn)
        
        self.delegate?.moveCanvas()
    }
    
    func erase(_ sender: Any) {
        setAllBtnsAsNotClicked()
        setBtnAsClicked(button: self.eraseBtn)
        
        self.delegate?.erase()
    }
    
    func drawOnCanvas(_ sender: Any) {
        setAllBtnsAsNotClicked()
        setBtnAsClicked(button: self.brushBtn)
        
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

extension UIColor {
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#")
            ? String(string.characters.dropFirst())
            : string
        guard hex.characters.count == 3 || hex.characters.count == 6
            else {
                self.init(white: 1.0, alpha: 0.0)
                return
        }
        if hex.characters.count == 3 {
            for (index, char) in hex.characters.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
}

