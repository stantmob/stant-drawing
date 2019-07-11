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
    
    let blackHexColor            = "#000000"
    let backgroundGroupGrayColor = UIColor(hex: "F0F0F0")
    
    private let bundle = Bundle(for: BrushToolView.self)
    
    private let toolInitX:  CGFloat = 10.0
    private let toolInitY:  CGFloat = 100.0
    private let toolWidth:  CGFloat = 85.0
    private let toolHeight: CGFloat = {
        let screenSize = UIScreen.main.bounds
        return screenSize.height
    }()
    
    private let buttonWidth: CGFloat  = 45
    private let buttonHeight: CGFloat = 45
    
    private lazy var groupViewWidth: CGFloat = {
        return self.toolWidth - (self.toolInitX * 2)
    }()
    
    private let groupToolsView           = UIView()
    private var separatorView            = UIView()
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
        configureLayouts(heightBaseToCenter: heightBaseToCenter, xBaseToCenter: x)
        
        if let uiButton = groupToolsButtons.first?.uiButton {
            setButtonAsClicked(button: uiButton)
        }
 
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
    
    private func configureLayouts(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        configureGroupToolsLayout()
        configureSeparatorLayout()
        configureGroupEndLayout()
        configureGroupPencilSizeLayout(heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        configureGroupEraseSizeLayout(heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        configureGroupSelectHexColorView(heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }
    
    private func loadGroupToolsButtons() {
                
        let moveButton  = Button(imageName: "move", imageColor: blackHexColor,   selector: #selector(self.moveCanvas))
        let brushButton = Button(imageName: "pencil", imageColor: blackHexColor, selector: #selector(self.drawOnCanvas))
        let eraseButton = Button(imageName: "eraserfull", imageColor: blackHexColor, selector: #selector(self.erase))
        let undoButton  = Button(imageName: "undo", imageColor: blackHexColor,   selector: #selector(self.undo))
        let redoButton  = Button(imageName: "redo", imageColor: blackHexColor,   selector: #selector(self.redo))
        let colorButton = Button(imageName: "selectColor", imageColor: (delegate?.getHexColor())!, selector: #selector(self.selectColor))
        
        
        groupToolsButtons.append(moveButton)
        groupToolsButtons.append(brushButton)
        groupToolsButtons.append(eraseButton)
        groupToolsButtons.append(undoButton)
        groupToolsButtons.append(redoButton)
        groupToolsButtons.append(colorButton)
    }
    
    private func loadGroupEndButtons() {
        let saveButton   = Button(imageName: "save", imageColor: "#00FF00", selector: #selector(self.save))
        let cancelButton = Button(imageName: "cancel", imageColor: "#FF0000", selector: #selector(self.cancel))
        
        groupEndButtons.append(saveButton)
        groupEndButtons.append(cancelButton)
    }
    
    private func loadGroupPencilSizeButtons() {
        let buttonSize1   = Button(imageName: "pencilSize1", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let buttonSize2   = Button(imageName: "pencilSize2", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let buttonSize3   = Button(imageName: "pencilSize3", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let buttonSize4   = Button(imageName: "pencilSize4", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let buttonSize5   = Button(imageName: "pencilSize5", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        let buttonSize6   = Button(imageName: "pencilSize6", imageColor: blackHexColor, selector: #selector(self.pencilSize))
        
        buttonSize1.uiButton.tag = 2
        buttonSize2.uiButton.tag = 5
        buttonSize3.uiButton.tag = 10
        buttonSize4.uiButton.tag = 30
        buttonSize5.uiButton.tag = 55
        buttonSize6.uiButton.tag = 80
        
        buttonSize1.uiButton.frame.size = CGSize(width: 13, height: 13)
        buttonSize2.uiButton.frame.size = CGSize(width: 18, height: 18)
        buttonSize3.uiButton.frame.size = CGSize(width: 23, height: 23)
        buttonSize4.uiButton.frame.size = CGSize(width: 28, height: 28)
        buttonSize5.uiButton.frame.size = CGSize(width: 33, height: 33)
        buttonSize6.uiButton.frame.size = CGSize(width: 37, height: 37)
        
        groupPencilSizeButtons.append(buttonSize1)
        groupPencilSizeButtons.append(buttonSize2)
        groupPencilSizeButtons.append(buttonSize3)
        groupPencilSizeButtons.append(buttonSize4)
        groupPencilSizeButtons.append(buttonSize5)
        groupPencilSizeButtons.append(buttonSize6)
    }
    
    private func loadGroupEraseSizeButtons() {
        let buttonSize1   = Button(imageName: "eraserSize1", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let buttonSize2   = Button(imageName: "eraserSize2", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let buttonSize3   = Button(imageName: "eraserSize3", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let buttonSize4   = Button(imageName: "eraserSize4", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let buttonSize5   = Button(imageName: "eraserSize5", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        let buttonSize6   = Button(imageName: "eraserSize6", imageColor: blackHexColor, selector: #selector(self.eraserSize))
        
        buttonSize1.uiButton.tag = 2
        buttonSize2.uiButton.tag = 5
        buttonSize3.uiButton.tag = 10
        buttonSize4.uiButton.tag = 30
        buttonSize5.uiButton.tag = 55
        buttonSize6.uiButton.tag = 80
        
        buttonSize1.uiButton.frame.size = CGSize(width: 13, height: 13)
        buttonSize2.uiButton.frame.size = CGSize(width: 18, height: 18)
        buttonSize3.uiButton.frame.size = CGSize(width: 23, height: 23)
        buttonSize4.uiButton.frame.size = CGSize(width: 28, height: 28)
        buttonSize5.uiButton.frame.size = CGSize(width: 33, height: 33)
        buttonSize6.uiButton.frame.size = CGSize(width: 37, height: 37)
        
        groupEraseSizeButtons.append(buttonSize1)
        groupEraseSizeButtons.append(buttonSize2)
        groupEraseSizeButtons.append(buttonSize3)
        groupEraseSizeButtons.append(buttonSize4)
        groupEraseSizeButtons.append(buttonSize5)
        groupEraseSizeButtons.append(buttonSize6)
    }
    
    private func configureGroupToolsLayout() {
        let origin = CGPoint(x: 0, y: 0)
        configureGroupLayout(buttons: groupToolsButtons, groupView: groupToolsView, groupViewOirigin: origin)
        
        setAllGroupdToolsButtonsAsNotClicked()
    }
    
    private func configureSeparatorLayout() {
        let yReference =  groupToolsView.frame.origin.y + groupToolsView.frame.height + 10
        
        separatorView = createSeparatorView(yReference:yReference)
        
        self.addSubview(separatorView)
    }
    
    private func configureGroupEndLayout() {
        let origin = CGPoint(x: 0, y: separatorView.frame.height + separatorView.frame.origin.y + 10)
        configureGroupLayout(buttons: groupEndButtons, groupView: groupEndView, groupViewOirigin: origin)
    }
    
    private func configureGroupPencilSizeLayout(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        configureGroupSizeLayout(groupButtons: groupPencilSizeButtons, groupSizeView: groupPencilSizeView, iconReferenceName: "pencil", heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }
    
    private func configureGroupEraseSizeLayout(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        configureGroupSizeLayout(groupButtons: groupEraseSizeButtons, groupSizeView: groupEraseSizeView, iconReferenceName: "eraserfull", heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }
    
    private func configureGroupSelectHexColorView(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        let y     = (heightBaseToCenter - groupSelectHexColorView!.frame.height)
        let point = CGPoint(x: xBaseToCenter, y: y)
        
        groupSelectHexColorView!.frame.origin = point
    }

    private func configureGroupSizeLayout(groupButtons: [Button], groupSizeView: UIView, iconReferenceName: String, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        // Icon
        let iconView = createReferenceIconSizeView(iconReferenceName: iconReferenceName)
        
        // Separator
        let yReference    = iconView.frame.origin.y + iconView.frame.height + 10
        let separatorView = createSeparatorView(yReference: yReference)
        
        // Group Buttons
        let yButtonsReference = separatorView.frame.origin.y + separatorView.frame.height + 10
        let groupButtonsView  = configGroupButtonsView(groupButtons: groupButtons, yReference: yButtonsReference)
        
        // GroupSizeView Configs
        let height    = iconView.frame.size.height + separatorView.frame.size.height + groupButtonsView.frame.size.height
        let sizeGroup = CGSize(width: self.frame.width, height: height)
        
        groupSizeView.frame.size = sizeGroup
        groupSizeView.isHidden   = true
        
        groupSizeView.addSubview(iconView)
        groupSizeView.addSubview(separatorView)
        groupSizeView.addSubview(groupButtonsView)
        
        centrilizeVerticalView(view: groupSizeView, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }
    
    private func configGroupButtonsView(groupButtons: [Button], yReference: CGFloat) -> UIView {
        let groupButtonsView = UIView()
        let origin           = CGPoint(x: 0, y: yReference)
        
        groupButtonsView.frame.origin = origin
        
        configureGroupLayout(buttons: groupButtons, groupView: groupButtonsView, groupViewOirigin: origin, addAsSubview: false)
        
        setButtonsAsNotClicked(buttons: groupButtons)
        
        // Set the second SizeButton as Default
        setButtonSizeAsClicked(button: groupButtons[1].uiButton)
        
        return groupButtonsView
    }
    
    private func createReferenceIconSizeView(iconReferenceName: String) -> UIView {
        let iconView = UIView()
        
        let originIconView = CGPoint(x: 0, y: 0)
        let sizeIconView   = CGSize(width: groupViewWidth, height: 60)
        let frameIconView  = CGRect.init(origin: originIconView, size: sizeIconView)
        
        iconView.frame              = frameIconView
        iconView.backgroundColor    = backgroundGroupGrayColor
        iconView.layer.cornerRadius = iconView.frame.width / 2
        
        let originIconImage = CGPoint(x: (groupViewWidth - 25) / 2, y: 18)
        let sizeIconImage   = CGSize(width: 25, height: 25)
        let frameIconImage  = CGRect.init(origin: originIconImage, size: sizeIconImage)
        
        let iconImageView = UIImageView(image: UIImage(named: iconReferenceName, in: bundle, compatibleWith: nil))
        
        let identifierName = "\(iconReferenceName)SizeReferenceIdentifier"
        setIdentifierForView(view: iconImageView, identifierName: identifierName)
        iconImageView.frame                   = frameIconImage
        
        iconView.addSubview(iconImageView)
        
        return iconView
    }
    
    private func createSeparatorView(yReference: CGFloat) -> UIView {
        let separatorView   = UIView()
        let originSeparator = CGPoint(x: 10, y: yReference)
        let sizeSeparator   = CGSize(width: groupViewWidth - 20, height: 1)
        let frameSeparator  = CGRect.init(origin: originSeparator, size: sizeSeparator)
        
        separatorView.frame           = frameSeparator
        separatorView.backgroundColor = UIColor.black
        separatorView.alpha           = 0.2
        
        return separatorView
    }
    
    private func setIdentifierForView(view: UIView, identifierName: String) {
        view.accessibilityIdentifier = identifierName
    }
    
    private func configureGroupLayout(buttons: [Button], groupView: UIView, groupViewOirigin: CGPoint, addAsSubview: Bool = true) {
        let _: [Button] = buttons.enumerated().map() { (index, button) in
            let uiButton = button.uiButton
            let size = uiButton.frame.size
            
            if index == 0 {
                uiButton.frame = buttonFrame(y: 20, size: size)
            } else {
                let referencedButton = buttons[index - 1].uiButton
                var yPlus: CGFloat = 75
                if size != CGSize(width: 0, height: 0) {
                    yPlus = 40
                }
                let y = referencedButton.frame.origin.y + yPlus
                uiButton.frame = nextButtonFrame(referencedY: y, size: size)
            }
            
            setImageEdgeInsets(button: uiButton)
            setButtonImage(button: uiButton, imageName: button.imageName, imageColor: button.imageColor)
            addButtonListener(uiButton, action: button.selector)

            groupView.addSubview(uiButton)
            
            return button
        }
        
        let lastUiButton = buttons.last!.uiButton
        
        let height = lastUiButton.frame.origin.y + lastUiButton.frame.height + 20
        let size   = CGSize(width: groupViewWidth, height: height)
        let frame  = CGRect.init(origin: groupViewOirigin, size: size)
        
        groupView.frame              = frame
        groupView.backgroundColor    = backgroundGroupGrayColor
        
        groupView.layer.cornerRadius = groupView.frame.width / 2
        
        if addAsSubview {
            self.addSubview(groupView)
        }
        
    }

    private func centrilizeVerticalView(view: UIView, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        let y     = (heightBaseToCenter - view.frame.height) / 2
        let point = CGPoint(x: xBaseToCenter, y: y)
        
        view.frame.origin = point
    }
    
    private func nextButtonFrame(referencedY: CGFloat, size: CGSize) -> CGRect {
        return buttonFrame(y: referencedY, size: size)
    }
    
    private func buttonFrame(y: CGFloat, size: CGSize) -> CGRect {
        
        if size == CGSize(width: 0, height: 0) {
            let x = (groupViewWidth - buttonWidth) / 2
            return CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        } else {
            let x = (groupViewWidth - size.width) / 2
            let origin = CGPoint(x: x, y: y)
            return CGRect(origin: origin, size: size)
        }
    }
    
    private func setImageEdgeInsets(button: UIButton) {
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setButtonImage(button: UIButton, imageName: String, imageColor: String) {
        let selectColorIcon      = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        let selectColorImageView = UIImageView()
        selectColorImageView.image = selectColorIcon
        
        button.setImage(selectColorImageView.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button.tintColor = UIColor(hex: imageColor)
    }
    
    private func addButtonListener(_ button: UIButton, action: Selector) {
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setButtonAsClicked(button: UIButton) {
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = UIColor.white
    }
    
    private func setButtonSizeAsClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
    }
    
    private func setButtonsAsNotClicked(buttons: [Button]) {
        buttons.forEach { button in
            setButtonSizeAsNotClicked(button: button.uiButton)
        }
    }
 
    private func setAllGroupdToolsButtonsAsNotClicked() {
        groupToolsButtons.forEach { button in
            setButtonAsNotClicked(button: button.uiButton)
        }
    }
    
    private func setButtonSizeAsNotClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 0.4
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
    }
    
    private func setButtonAsNotClicked(button: UIButton) {
        button.alpha = 0.4
        button.backgroundColor = UIColor.clear
    }
    
    // MARK: IBActions
    
    @objc func moveCanvas(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        setButtonAsClicked(button: sender)
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
        setButtonAsClicked(button: sender)
        
        self.delegate?.erase()
    }
    
    @objc func drawOnCanvas(_ sender: UIButton) {
        setAllGroupdToolsButtonsAsNotClicked()
        setButtonAsClicked(button: sender)
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
        
        setButtonAsClicked(button: sender)
        groupSelectHexColorView?.selectColorCollectionView.brushDelegate = delegate
    }
    
    @objc func pencilSize(_ sender: UIButton) {
        setButtonsAsNotClicked(buttons: groupPencilSizeButtons)
        setButtonSizeAsClicked(button: sender)

        delegate?.changePencilSize(CGFloat(sender.tag))
    }
    
    @objc func eraserSize(_ sender: UIButton) {
        setButtonsAsNotClicked(buttons: groupEraseSizeButtons)
        setButtonSizeAsClicked(button: sender)
        
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
