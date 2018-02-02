//
//  BrushView.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import UIKit
import Foundation

struct Button {
    let uiButton = UIButton()
    let imageName: String
    let selector: Selector
}

public class BrushToolView: UIView {
    var delegate: BrushToolContract?
    
    private let bundle = Bundle(for: BrushToolView.self)
    
    private let toolInitX:  CGFloat = 10.0
    private let toolInitY:  CGFloat = 100.0
    private let toolWidth:  CGFloat = 85.0
    private let toolHeight: CGFloat = {
        let screenSize = UIScreen.main.bounds
        return screenSize.height
    }()
    
    private let btnWidth: CGFloat  = 45
    private let btnHeight: CGFloat = 45
    
    private lazy var groupViewWidth: CGFloat = {
        return self.toolWidth - (self.toolInitX * 2)
    }()
    
    private let groupToolsView      = UIView()
    private let separatorView       = UIView()
    private let groupEndView        = UIView()
    private let groupPencilSizeView = UIView()
    private let groupEraseSizeView  = UIView()
    
    private var groupToolsButtons      = [Button]()
    private var groupEndButtons        = [Button]()
    private var groupPencilSizeButtons = [Button]()
    private var groupEraseSizeButtons  = [Button]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let frame = CGRect(x: toolInitX, y: toolInitY, width: toolWidth, height: toolHeight)
        super.init(frame: frame)
        
        loadButtons()
        configureLayouts()
        
        if let uiButton = groupToolsButtons.first?.uiButton {
            setBtnAsClicked(button: uiButton)
        }
        
    }
    
    func addAsSubViewOn(_ view: UIView, x: CGFloat, heightBaseToCenter: CGFloat) {
        let y = (heightBaseToCenter - groupPencilSizeView.frame.height) / 2
        let point = CGPoint(x: x, y: y)
        
        groupPencilSizeView.frame.origin = point
        groupEraseSizeView.frame.origin  = point
        
        view.addSubview(groupPencilSizeView)
        view.addSubview(groupEraseSizeView)
    }
    
    private func loadButtons() {
        loadGroupToolsButtons()
        loadGroupEndButtons()
        loadGroupPencilSizeButtons()
        loadGroupEraseSizeButtons()
    }
    
    private func configureLayouts() {
        configureGroupToolsLayout()
        configureSeparatorLayout()
        configureGroupEndLayout()
        configureGroupPencilSizeLayout()
        configureGroupEraseSizeLayout()
    }
    
    private func loadGroupToolsButtons() {
        let moveBtn  = Button(imageName: "move",   selector: #selector(self.moveCanvas))
        let brushBtn = Button(imageName: "pencil", selector: #selector(self.drawOnCanvas))
        let eraseBtn = Button(imageName: "eraserfull", selector: #selector(self.erase))
        let undoBtn  = Button(imageName: "undo",   selector: #selector(self.undo))
        let redoBtn  = Button(imageName: "redo",   selector: #selector(self.redo))

        groupToolsButtons.append(moveBtn)
        groupToolsButtons.append(brushBtn)
        groupToolsButtons.append(eraseBtn)
        groupToolsButtons.append(undoBtn)
        groupToolsButtons.append(redoBtn)
    }
    
    private func loadGroupEndButtons() {
        let saveBtn   = Button(imageName: "save",   selector: #selector(self.save))
        let cancelBtn = Button(imageName: "cancel", selector: #selector(self.cancel))
        
        groupEndButtons.append(saveBtn)
        groupEndButtons.append(cancelBtn)
    }
    
    private func loadGroupPencilSizeButtons() {
        let btnSize1   = Button(imageName: "",   selector: #selector(self.pencilSize))
        let btnSize2   = Button(imageName: "",   selector: #selector(self.pencilSize))
        let btnSize3   = Button(imageName: "",   selector: #selector(self.pencilSize))
        let btnSize4   = Button(imageName: "",   selector: #selector(self.pencilSize))
        btnSize1.uiButton.tag = 10
        btnSize2.uiButton.tag = 30
        btnSize3.uiButton.tag = 55
        btnSize4.uiButton.tag = 80
        
        btnSize1.uiButton.frame.size = CGSize(width: 23, height: 23)
        btnSize2.uiButton.frame.size = CGSize(width: 28, height: 28)
        btnSize3.uiButton.frame.size = CGSize(width: 33, height: 33)
        btnSize4.uiButton.frame.size = CGSize(width: 37, height: 37)
        
        groupPencilSizeButtons.append(btnSize1)
        groupPencilSizeButtons.append(btnSize2)
        groupPencilSizeButtons.append(btnSize3)
        groupPencilSizeButtons.append(btnSize4)
    }
    
    private func loadGroupEraseSizeButtons() {
        let eraser     = Button(imageName: "eraser",     selector: #selector(self.eraserSize))
        let eraserFull = Button(imageName: "eraserfull", selector: #selector(self.eraserSize))
        
        eraser.uiButton.tag     = 30
        eraserFull.uiButton.tag = 80
        
        groupEraseSizeButtons.append(eraser)
        groupEraseSizeButtons.append(eraserFull)
    }
    
    private func configureGroupToolsLayout() {
        let origin = CGPoint(x: 0, y: 0)
        configureGroupLayout(buttons: groupToolsButtons, groupView: groupToolsView, groupViewOirigin: origin)
        
        setAllGroupdToolsButtonsAsNotClicked()
    }
    
    private func configureSeparatorLayout() {
        let origin = CGPoint(x: 10, y: groupToolsView.frame.origin.y + groupToolsView.frame.height + 10)
        let size = CGSize(width: groupViewWidth - 20, height: 1)
        let frame = CGRect.init(origin: origin, size: size)
        separatorView.frame = frame
        
        separatorView.backgroundColor = UIColor.black
        separatorView.alpha = 0.2
        
        self.addSubview(separatorView)
    }
    
    private func configureGroupEndLayout() {
        let origin = CGPoint(x: 0, y: separatorView.frame.height + separatorView.frame.origin.y + 10)
        configureGroupLayout(buttons: groupEndButtons, groupView: groupEndView, groupViewOirigin: origin)
    }
    
    private func configureGroupPencilSizeLayout() {
        let origin = CGPoint(x: groupToolsView.frame.width + groupToolsView.frame.origin.x + 10, y: 0)
        configureGroupLayout(buttons: groupPencilSizeButtons, groupView: groupPencilSizeView, groupViewOirigin: origin, addAsSubview: false)
        groupPencilSizeView.isHidden = true
        
        setAllGroupdPencilSizeButtonsAsNotClicked()

        if let uiButton = groupPencilSizeButtons.first?.uiButton {
            setBtnSizeAsClicked(button: uiButton)
        }
    }
    
    private func configureGroupEraseSizeLayout() {
        let origin = CGPoint(x: groupToolsView.frame.width + groupToolsView.frame.origin.x + 10, y: 0)
        configureGroupLayout(buttons: groupEraseSizeButtons, groupView: groupEraseSizeView, groupViewOirigin: origin, addAsSubview: false)
        groupEraseSizeView.isHidden = true
        
        setAllGroupdEraseSizeButtonsAsNotClicked()
        
        if let uiButton = groupEraseSizeButtons.first?.uiButton {
            setBtnAsClicked(button: uiButton)
        }
    }
    
    private func configureGroupLayout(buttons: [Button], groupView: UIView, groupViewOirigin: CGPoint, addAsSubview: Bool = true) {
        let _: [Button] = buttons.enumerated().map() { (index, btn) in
            let uiButton = btn.uiButton
            let size = uiButton.frame.size
            
            if index == 0 {
                uiButton.frame = btnFrame(y: 20, size: size)
            } else {
                let referencedBtn = buttons[index - 1].uiButton
                var yPlus: CGFloat = 75
                if size != CGSize(width: 0, height: 0) {
                    yPlus = 40
                }
                let y = referencedBtn.frame.origin.y + yPlus
                uiButton.frame = nextBtnFrame(referencedY: y, size: size)
            }
            
            setImageEdgeInsets(btn: uiButton)
            setBtnImage(btn: uiButton, imageName: btn.imageName)
            addBtnListener(uiButton, action: btn.selector)

            groupView.addSubview(uiButton)
            
            return btn
        }
        
        let lastUiButton = buttons.last!.uiButton
        
        let height = lastUiButton.frame.origin.y + lastUiButton.frame.height + 20
        let size   = CGSize(width: groupViewWidth, height: height)
        let frame  = CGRect.init(origin: groupViewOirigin, size: size)
        
        groupView.frame              = frame
        groupView.backgroundColor    = UIColor(hex: "F0F0F0")
        groupView.layer.cornerRadius = groupView.frame.width / 2
        
        if addAsSubview {
            self.addSubview(groupView)
        }
        
    }
    
    private func nextBtnFrame(referencedY: CGFloat, size: CGSize) -> CGRect {
        return btnFrame(y: referencedY, size: size)
    }
    
    private func btnFrame(y: CGFloat, size: CGSize) -> CGRect {
        
        if size == CGSize(width: 0, height: 0) {
            let x = (groupViewWidth - btnWidth) / 2
            return CGRect(x: x, y: y, width: btnWidth, height: btnHeight)
        } else {
            let x = (groupViewWidth - size.width) / 2
            let origin = CGPoint(x: x, y: y)
            return CGRect(origin: origin, size: size)
        }
    }
    
    private func setImageEdgeInsets(btn: UIButton) {
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setBtnImage(btn: UIButton, imageName: String) {
        let image = UIImage.init(named: imageName, in: bundle, compatibleWith: nil)
        btn.setImage(image, for: .normal)
    }
    
    private func addBtnListener(_ btn: UIButton, action: Selector) {
        btn.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setBtnAsClicked(button: UIButton) {
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = UIColor.white
    }
    
    private func setBtnSizeAsClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
    }
    
    private func setAllGroupdPencilSizeButtonsAsNotClicked() {
        groupPencilSizeButtons.forEach { btn in
            setBtnSizeAsNotClicked(button: btn.uiButton)
        }
    }
    
    private func setAllGroupdEraseSizeButtonsAsNotClicked() {
        groupEraseSizeButtons.forEach { btn in
            setBtnAsNotClicked(button: btn.uiButton)
        }
    }
    
    private func setAllGroupdToolsButtonsAsNotClicked() {
        groupToolsButtons.forEach { btn in
            setBtnAsNotClicked(button: btn.uiButton)
        }
    }
    
    private func setBtnSizeAsNotClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 0.4
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
    }
    
    private func setBtnAsNotClicked(button: UIButton) {
        button.alpha = 0.4
        button.backgroundColor = UIColor.clear
    }
    
    // MARK: IBActions
    
    @objc func moveCanvas(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        setBtnAsClicked(button: sender)
        hideEraseSizeView()
        hidePencilSizeView()
        self.delegate?.moveCanvas()
    }
    
    @objc func erase(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        hidePencilSizeView()
        showEraseSizeView()
        setBtnAsClicked(button: sender)
        
        self.delegate?.erase()
    }
    
    @objc func drawOnCanvas(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        setBtnAsClicked(button: sender)
        hideEraseSizeView()
        showPencilSizeView()
        delegate?.draw()
    }
    
    @objc func undo(_ sender: Any) {
        self.delegate?.undo()
    }
    
    @objc func redo(_ sender: Any) {
        self.delegate?.redo()
    }
    
    @objc func pencilSize(_ sender: UIButton) {
        setAllGroupdPencilSizeButtonsAsNotClicked()
        setBtnSizeAsClicked(button: sender)

        delegate?.changePencilSize(CGFloat(sender.tag))
    }
    
    @objc func eraserSize(_ sender: UIButton) {
        setAllGroupdEraseSizeButtonsAsNotClicked()
        setBtnAsClicked(button: sender)
        
        delegate?.changeEraserSize(CGFloat(sender.tag))
    }

    @objc func save(_ sender: Any) {
        let alert = UIAlertController(title: "Salvar", message: "Deseja salvar as alterações e sair do modo de seleção?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.save()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
    
    @objc func cancel(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja cancelar a edição? Todas alterações serão perdidas", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.delegate?.cancel()
        }))
        UIApplication.shared.keyWindow?.rootViewController!.topMostViewController().present(alert, animated: true, completion: nil)
    }
    
    
    func showPencilSizeView() {
        groupPencilSizeView.isHidden = false
    }
    
    func hidePencilSizeView() {
        groupPencilSizeView.isHidden = true
    }
    
    func showEraseSizeView() {
        groupEraseSizeView.isHidden = false
    }
    
    func hideEraseSizeView() {
        groupEraseSizeView.isHidden = true
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
