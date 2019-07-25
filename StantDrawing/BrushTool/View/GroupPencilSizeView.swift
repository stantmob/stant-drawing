//
//  GroupPencilSizeView.swift
//  Pods-MyFirstDrawing
//
//  Created by Stant Macmini n04 on 25/07/19.
//

import UIKit
import Foundation

public protocol GroupSizeContract {
    func pencilSize(_ size: CGFloat)
}

public class GroupPencilSizeView: UIView {
    
    private let groupPencilSizeViewIdentifier = "groupPencilSizeView"
    private let backgroundGroupGrayColor      = UIColor(hex: "F0F0F0")
    private let blackHexColor            = "#000000"
    
    private let buttonWidth: CGFloat  = 45
    private let buttonHeight: CGFloat = 45
    
    private var bundle = Bundle()
    
    private var groupPencilSizeButtons = [Button]()
    
    private var groupViewWidth = CGFloat()
    
    private var delegate: GroupSizeContract?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.init(frame: frame)
    }
    
    func conf(delegate: GroupSizeContract, bundle: Bundle, rootGroupView: CGFloat, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        self.delegate = delegate
        self.bundle    = bundle
        groupViewWidth = rootGroupView
        
        loadGroupPencilSizeButtons()
        
//        self.groupPencilSizeButtons = groupPencilSizeButtons
        
        configureGroupSizeLayout(groupButtons: groupPencilSizeButtons, groupSizeView: self, iconReferenceName: "pencil", heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
        
        setIdentifierForView(view: self, identifierName: groupPencilSizeViewIdentifier)
    }
    
    private func loadGroupPencilSizeButtons() {
        let buttonSize1   = Button(imageName: "pencilSize1", imageColor: blackHexColor, selector: #selector(pencilSize))
        let buttonSize2   = Button(imageName: "pencilSize2", imageColor: blackHexColor, selector: #selector(pencilSize))
        let buttonSize3   = Button(imageName: "pencilSize3", imageColor: blackHexColor, selector: #selector(pencilSize))
        let buttonSize4   = Button(imageName: "pencilSize4", imageColor: blackHexColor, selector: #selector(pencilSize))
        let buttonSize5   = Button(imageName: "pencilSize5", imageColor: blackHexColor, selector: #selector(pencilSize))
        let buttonSize6   = Button(imageName: "pencilSize6", imageColor: blackHexColor, selector: #selector(pencilSize))
        
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
    
    private func setButtonsAsNotClicked(buttons: [Button]) {
        buttons.forEach { button in
            setButtonSizeAsNotClicked(button: button.uiButton)
        }
    }
    private func setButtonSizeAsClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
    }
    
    private func setButtonSizeAsNotClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        button.alpha = 0.4
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor = darkGray
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
    
    private func addButtonListener(_ button: UIButton, action: Selector) {
        button.addTarget(self, action: action, for: .touchUpInside)
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
    
    @objc func pencilSize(_ sender: UIButton) {
        setButtonsAsNotClicked(buttons: groupPencilSizeButtons)
        setButtonSizeAsClicked(button: sender)
        
        delegate?.pencilSize(CGFloat(sender.tag))
    }
}
