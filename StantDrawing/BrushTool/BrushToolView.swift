//
//  BrushView.swift
//  StantDrawing
//
//  Created by Rachid Calazans on 03/07/17.
//  Copyright © 2017 Stant. All rights reserved.
//

import UIKit
import Foundation

public struct Button {
    let uiButton = UIButton()
    let imageName: String
    let imageColor: String
    let selector : Selector

    init(imageName: String, imageColor: String, selector: Selector) {
        self.imageName  = imageName
        self.imageColor = imageColor
        self.selector   = selector
        
        setUiButtonIdentifier()
    }
    
    private func setUiButtonIdentifier() {
        self.uiButton.accessibilityIdentifier = "\(self.imageName)Identifier"
    }
}

public class BrushToolView: UIView {
    var delegate: BrushToolContract?
    let blackHexColor  = "#000000"
    
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
    
    private let groupToolsView           = UIView()
    private let separatorView            = UIView()
    private let groupEndView             = UIView()
    private let groupPencilSizeView      = UIView()
    private let groupEraseSizeView       = UIView()
    private var groupSelectHexColorView: SelectColorView?
    
    public  var groupToolsButtons      = [Button]()
    private var groupEndButtons        = [Button]()
    private var groupPencilSizeButtons = [Button]()
    private var groupEraseSizeButtons  = [Button]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let frame = CGRect(x: toolInitX, y: toolInitY, width: toolWidth, height: toolHeight)
        super.init(frame: frame)
        
        groupSelectHexColorView = SelectColorView(frame: CGRect(x: 0,
                                                                y: 0,
                                                                width: 90,
                                                                height: 500))
        
    }
    
    func addAsSubViewOn(_ view: UIView, x: CGFloat, heightBaseToCenter: CGFloat) {
        loadButtons()
        configureLayouts()
        if let uiButton = groupToolsButtons.first?.uiButton {
            setBtnAsClicked(button: uiButton)
        }
        
        let y = (heightBaseToCenter - groupPencilSizeView.frame.height) / 2
        let point = CGPoint(x: x, y: y)

        groupPencilSizeView.frame.origin = point
        groupEraseSizeView.frame.origin  = point
        groupSelectHexColorView?.frame.origin = CGPoint(x: x - 10, y: groupPencilSizeView.frame.height - 50)

        view.addSubview(groupSelectHexColorView!)
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
                
        let moveBtn  = Button(imageName: "move", imageColor: blackHexColor,   selector: #selector(self.moveCanvas))
        let brushBtn = Button(imageName: "pencil", imageColor: blackHexColor, selector: #selector(self.drawOnCanvas))
        let eraseBtn = Button(imageName: "eraserfull", imageColor: blackHexColor, selector: #selector(self.erase))
        let undoBtn  = Button(imageName: "undo", imageColor: blackHexColor,   selector: #selector(self.undo))
        let redoBtn  = Button(imageName: "redo", imageColor: blackHexColor,   selector: #selector(self.redo))
        let colorBtn = Button(imageName: "selectColor", imageColor: (delegate?.getHexColor())!, selector: #selector(self.selectColor))
        
        
        groupToolsButtons.append(moveBtn)
        groupToolsButtons.append(brushBtn)
        groupToolsButtons.append(eraseBtn)
        groupToolsButtons.append(undoBtn)
        groupToolsButtons.append(redoBtn)
        groupToolsButtons.append(colorBtn)
    }
    
    private func loadGroupEndButtons() {
        let saveBtn   = Button(imageName: "save", imageColor: "#00FF00", selector: #selector(self.save))
        let cancelBtn = Button(imageName: "cancel", imageColor: "#FF0000", selector: #selector(self.cancel))
        
        groupEndButtons.append(saveBtn)
        groupEndButtons.append(cancelBtn)
    }
    
    private func loadGroupPencilSizeButtons() {
        let btnSize1   = Button(imageName: "pencilSize1", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let btnSize2   = Button(imageName: "pencilSize2", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let btnSize3   = Button(imageName: "pencilSize3", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let btnSize4   = Button(imageName: "pencilSize4", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let btnSize5   = Button(imageName: "pencilSize5", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let btnSize6   = Button(imageName: "pencilSize6", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        
        btnSize1.uiButton.tag = 2
        btnSize2.uiButton.tag = 5
        btnSize3.uiButton.tag = 10
        btnSize4.uiButton.tag = 30
        btnSize5.uiButton.tag = 55
        btnSize6.uiButton.tag = 80
        
        btnSize1.uiButton.frame.size = CGSize(width: 13, height: 13)
        btnSize2.uiButton.frame.size = CGSize(width: 18, height: 18)
        btnSize3.uiButton.frame.size = CGSize(width: 23, height: 23)
        btnSize4.uiButton.frame.size = CGSize(width: 28, height: 28)
        btnSize5.uiButton.frame.size = CGSize(width: 33, height: 33)
        btnSize6.uiButton.frame.size = CGSize(width: 37, height: 37)
        
        groupPencilSizeButtons.append(btnSize1)
        groupPencilSizeButtons.append(btnSize2)
        groupPencilSizeButtons.append(btnSize3)
        groupPencilSizeButtons.append(btnSize4)
        groupPencilSizeButtons.append(btnSize5)
        groupPencilSizeButtons.append(btnSize6)
    }
    
    private func loadGroupEraseSizeButtons() {
        let btnSize1   = Button(imageName: "eraserSize1", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let btnSize2   = Button(imageName: "eraserSize2", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let btnSize3   = Button(imageName: "eraserSize3", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let btnSize4   = Button(imageName: "eraserSize4", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let btnSize5   = Button(imageName: "eraserSize5", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let btnSize6   = Button(imageName: "eraserSize6", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        
        btnSize1.uiButton.tag = 2
        btnSize2.uiButton.tag = 5
        btnSize3.uiButton.tag = 10
        btnSize4.uiButton.tag = 30
        btnSize5.uiButton.tag = 55
        btnSize6.uiButton.tag = 80
        
        btnSize1.uiButton.frame.size = CGSize(width: 13, height: 13)
        btnSize2.uiButton.frame.size = CGSize(width: 18, height: 18)
        btnSize3.uiButton.frame.size = CGSize(width: 23, height: 23)
        btnSize4.uiButton.frame.size = CGSize(width: 28, height: 28)
        btnSize5.uiButton.frame.size = CGSize(width: 33, height: 33)
        btnSize6.uiButton.frame.size = CGSize(width: 37, height: 37)
        
        groupEraseSizeButtons.append(btnSize1)
        groupEraseSizeButtons.append(btnSize2)
        groupEraseSizeButtons.append(btnSize3)
        groupEraseSizeButtons.append(btnSize4)
        groupEraseSizeButtons.append(btnSize5)
        groupEraseSizeButtons.append(btnSize6)
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
        // Pencil Icon
        let pencilIconView   = UIView()
        
        let originIconView = CGPoint(x: 0, y: 0)
        let sizeIconView   = CGSize(width: groupViewWidth, height: 60)
        let frameIconView  = CGRect.init(origin: originIconView, size: sizeIconView)
        
        pencilIconView.frame              = frameIconView
        pencilIconView.backgroundColor    = UIColor(hex: "F0F0F0")
        pencilIconView.layer.cornerRadius = pencilIconView.frame.width / 2
        
        let originIconImg = CGPoint(x: (groupViewWidth - 25) / 2, y: 18)
        let sizeIconImg   = CGSize(width: 25, height: 25)
        let frameIconImg  = CGRect.init(origin: originIconImg, size: sizeIconImg)
        
        let pencilIconImageView = UIImageView(image: UIImage(named: "pencil", in: bundle, compatibleWith: nil))
        
        pencilIconImageView.accessibilityIdentifier = "pencilSizeReferenceIdentifier"
        pencilIconImageView.frame                   = frameIconImg
        
        pencilIconView.addSubview(pencilIconImageView)

        // Separator
        let separatorView   = UIView()
        let originSeparator = CGPoint(x: 10, y: pencilIconView.frame.origin.y + pencilIconView.frame.height + 10)
        let sizeSeparator   = CGSize(width: groupViewWidth - 20, height: 1)
        let frameSeparator  = CGRect.init(origin: originSeparator, size: sizeSeparator)

        separatorView.frame = frameSeparator
        separatorView.backgroundColor = UIColor.black
        separatorView.alpha = 0.2

        // Group Pencil Buttons
        let groupPencilBtns = UIView()
        let origin          = CGPoint(x: 0, y: separatorView.frame.origin.y + separatorView.frame.height + 10)
        
        groupPencilBtns.frame.origin = origin
        
        configureGroupLayout(buttons: groupPencilSizeButtons, groupView: groupPencilBtns, groupViewOirigin: origin, addAsSubview: false)
        
        setAllGroupdPencilSizeButtonsAsNotClicked()
        
        setBtnSizeAsClicked(button: groupPencilSizeButtons[1].uiButton)
        
        // GroupPencilSizeView Configs
        let height    = pencilIconView.frame.size.height + separatorView.frame.size.height + groupPencilBtns.frame.size.height
        let sizeGroup = CGSize(width: self.frame.width, height: height)
        groupPencilSizeView.frame.size = sizeGroup
        groupPencilSizeView.isHidden   = true
        
        groupPencilSizeView.addSubview(pencilIconView)
        groupPencilSizeView.addSubview(separatorView)
        groupPencilSizeView.addSubview(groupPencilBtns)
    }
    
    private func configureGroupEraseSizeLayout() {
        // Erase Icon
        let eraseIconView   = UIView()
        
        let originIconView = CGPoint(x: 0, y: 0)
        let sizeIconView   = CGSize(width: groupViewWidth, height: 60)
        let frameIconView  = CGRect.init(origin: originIconView, size: sizeIconView)
        
        eraseIconView.frame              = frameIconView
        eraseIconView.backgroundColor    = UIColor(hex: "F0F0F0")
        eraseIconView.layer.cornerRadius = eraseIconView.frame.width / 2
        
        let originIconImg = CGPoint(x: (groupViewWidth - 25) / 2, y: 18)
        let sizeIconImg   = CGSize(width: 25, height: 25)
        let frameIconImg  = CGRect.init(origin: originIconImg, size: sizeIconImg)
        
        let eraseIconImageView = UIImageView(image: UIImage(named: "eraserfull", in: bundle, compatibleWith: nil))
        
        eraseIconImageView.accessibilityIdentifier = "eraserfullReferenceIdentifier"
        eraseIconImageView.frame                    = frameIconImg
        
        eraseIconView.addSubview(eraseIconImageView)
        
        // Separator
        let separatorView   = UIView()
        let originSeparator = CGPoint(x: 10, y: eraseIconView.frame.origin.y + eraseIconView.frame.height + 10)
        let sizeSeparator   = CGSize(width: groupViewWidth - 20, height: 1)
        let frameSeparator  = CGRect.init(origin: originSeparator, size: sizeSeparator)
        
        separatorView.frame = frameSeparator
        separatorView.backgroundColor = UIColor.black
        separatorView.alpha = 0.2
        
        // Group Erase Buttons
        let groupEraseBtns = UIView()
        let origin          = CGPoint(x: 0, y: separatorView.frame.origin.y + separatorView.frame.height + 10)
        
        groupEraseBtns.frame.origin = origin
        
        configureGroupLayout(buttons: groupEraseSizeButtons, groupView: groupEraseBtns, groupViewOirigin: origin, addAsSubview: false)
        
        setAllGroupdEraseSizeButtonsAsNotClicked()
        
        setBtnSizeAsClicked(button: groupEraseSizeButtons[1].uiButton)
        
        // GroupPencilSizeView Configs
        let height    = eraseIconView.frame.size.height + separatorView.frame.size.height + groupEraseBtns.frame.size.height
        let sizeGroup = CGSize(width: self.frame.width, height: height)
        groupEraseSizeView.frame.size = sizeGroup
        groupEraseSizeView.isHidden   = true
        
        groupEraseSizeView.addSubview(eraseIconView)
        groupEraseSizeView.addSubview(separatorView)
        groupEraseSizeView.addSubview(groupEraseBtns)
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
            setBtnImage(btn: uiButton, imageName: btn.imageName, imageColor: btn.imageColor)
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
    
    private func setBtnImage(btn: UIButton, imageName: String, imageColor: String) {
        let selectColorIcon      = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        let selectColorImageView = UIImageView()
        selectColorImageView.image = selectColorIcon
        
        btn.setImage(selectColorImageView.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        btn.tintColor = UIColor(hex: imageColor)
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
            setBtnSizeAsNotClicked(button: btn.uiButton)
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
        hideSelectColorView()
        self.delegate?.moveCanvas()
    }
    
    @objc func erase(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        hidePencilSizeView()
        hideSelectColorView()
        showEraseSizeView()
        setBtnAsClicked(button: sender)
        
        self.delegate?.erase()
    }
    
    @objc func drawOnCanvas(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        setBtnAsClicked(button: sender)
        hideEraseSizeView()
        hideSelectColorView()
        showPencilSizeView()
        delegate?.draw()
    }
    
    @objc func undo(_ sender: Any) {
        self.delegate?.undo()
    }
    
    @objc func redo(_ sender: Any) {
        self.delegate?.redo()
    }
    
    @objc func selectColor(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        hideEraseSizeView()
        hidePencilSizeView()
        showSelectColorView()
        
        setBtnAsClicked(button: sender)
        groupSelectHexColorView?.selectColorCollectionView.brushDelegate = delegate
    }
    
    @objc func pencilSize(_ sender: UIButton) {
        setAllGroupdPencilSizeButtonsAsNotClicked()
        setBtnSizeAsClicked(button: sender)

        delegate?.changePencilSize(CGFloat(sender.tag))
    }
    
    @objc func eraserSize(_ sender: UIButton) {
        setAllGroupdEraseSizeButtonsAsNotClicked()
        setBtnSizeAsClicked(button: sender)
        
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
    
    func showSelectColorView() {
        groupSelectHexColorView?.showSelectColorGroup()
    }
    
    func hideSelectColorView() {
        groupSelectHexColorView?.setupCollapsed()
        groupSelectHexColorView?.hideSelectColorGroup()
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
