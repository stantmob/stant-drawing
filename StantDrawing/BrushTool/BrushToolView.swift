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

public class BrushToolView: UIView, GroupSizeContract {

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
    
    private var rootView = UIView()
    
    private let groupToolsView           = UIView()
    private var separatorView            = UIView()
    private let groupEndView             = UIView()
    private var groupPencilSizeView      = UIView()
    private var groupEraseSizeView       = UIView()
    private lazy var groupSelectHexColorView = { return SelectColorView(frame: CGRect(x: 0, y: 0, width: 90, height: 500)) }()
    
    public  var groupToolsButtons      = [Button]()
    private var groupEndButtons        = [Button]()
    
    private let groupSelectHexColorViewIdentifier = "groupSelectHexColorView"
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let frame = CGRect(x: toolInitX, y: toolInitY, width: toolWidth, height: toolHeight)
        super.init(frame: frame)
    }

    func addAsSubViewOn(_ view: UIView, x: CGFloat, heightBaseToCenter: CGFloat) {
        self.rootView = view
        loadButtons()
        configureLayouts(heightBaseToCenter: heightBaseToCenter, xBaseToCenter: x)
        
        if let uiButton = groupToolsButtons.first?.uiButton {
            setButtonAsClicked(button: uiButton)
        }
    }
    
    private func loadButtons() {
        loadGroupToolsButtons()
        loadGroupEndButtons()
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
        let groupPencilSizeView = GroupPencilSizeView(delegate: self, bundle: bundle, rootGroupView: groupViewWidth, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        
        self.groupPencilSizeView = groupPencilSizeView
    }
    
    private func configureGroupEraseSizeLayout(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        let groupEraseSizeView = GroupEraseSizeView(delegate: self, bundle: bundle, rootGroupView: groupViewWidth, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        
        self.groupEraseSizeView = groupEraseSizeView
    }
    
    private func configureGroupSelectHexColorView(heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        let y     = (heightBaseToCenter - groupSelectHexColorView.frame.height)
        let point = CGPoint(x: xBaseToCenter, y: y)
        
        groupSelectHexColorView.frame.origin = point
        
        setIdentifierForView(view: groupSelectHexColorView, identifierName: groupSelectHexColorViewIdentifier)

        groupSelectHexColorView.selectColorCollectionView.brushDelegate = delegate
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
    
    private func nextButtonFrame(referencedY: CGFloat, size: CGSize) -> CGRect {
        return buttonFrame(y: referencedY, size: size)
    }
    
    private func buttonFrame(y: CGFloat, size: CGSize) -> CGRect {
        if size == CGSize(width: 0, height: 0) {
            let x = (groupViewWidth - buttonWidth) / 2
            return CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        }
        
        let x = (groupViewWidth - size.width) / 2
        let origin = CGPoint(x: x, y: y)
        return CGRect(origin: origin, size: size)
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
        removeSubViews()
        setAllGroupdToolsButtonsAsNotClicked()
        setButtonAsClicked(button: sender)

        self.delegate?.moveCanvas()
    }
    
    @objc func erase(_ sender: UIButton) {
        removeSubViews()
        rootView.addSubview(groupEraseSizeView)
        
        setAllGroupdToolsButtonsAsNotClicked()
        setButtonAsClicked(button: sender)

        self.delegate?.erase()
    }
    
    @objc func drawOnCanvas(_ sender: UIButton) {
        removeSubViews()
        rootView.addSubview(groupPencilSizeView)
        
        setAllGroupdToolsButtonsAsNotClicked()
        setButtonAsClicked(button: sender)

        delegate?.draw()
    }
    
    @objc func undo(_ sender: Any) {
        self.delegate?.undo()
    }
    
    @objc func redo(_ sender: Any) {
        self.delegate?.redo()
    }
    
    @objc func selectColor(_ sender: UIButton) {
        removeSubViews()
        rootView.addSubview(groupSelectHexColorView)
        
        setAllGroupdToolsButtonsAsNotClicked()
        
        setButtonAsClicked(button: sender)
    }
    
    fileprivate func removeSubViews() {
        let identifiersToRemove = [GroupPencilSizeView.groupPencilSizeViewIdentifier, GroupEraseSizeView.groupEraseSizeViewIdentifier, groupSelectHexColorViewIdentifier]
        
        for subView in rootView.subviews {
            if let identifier = subView.accessibilityIdentifier {
                if identifiersToRemove.contains(identifier) {
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    public func selectSize(_ size: CGFloat, groupSize: GroupSizeType) {
        switch groupSize {
            
        case .pencil:
            delegate?.changePencilSize(size)
        case .erase:
            delegate?.changeEraserSize(size)
        }
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
