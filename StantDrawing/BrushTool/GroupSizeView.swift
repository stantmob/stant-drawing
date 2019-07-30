//
//  GroupSizeView.swift
//  StantDrawing
//
//  Created by Stant Macmini n04 on 29/07/19.
//

import UIKit
import Foundation

public protocol GroupSizeContract {
    func selectSize(_ size: CGFloat, groupSize: GroupSizeType)
}

public enum GroupSizeType {
    case pencil
    case erase
}

public class GroupSizeView: UIView {
    private let backgroundGroupGrayColor = UIColor(hex: "F0F0F0")
    
    private var iconReferenceName   = ""
    private var buttonSizeImageName = ""
    
    private var groupSizeButtons = [Button]()
    
    private let buttonWidth: CGFloat  = 45
    private let buttonHeight: CGFloat = 45
    
    private let bundle: Bundle
    
    private let groupViewWidth: CGFloat
    
    private let delegate: GroupSizeContract
    
    private let groupSizeType: GroupSizeType
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(groupSizeType: GroupSizeType, iconReferenceName: String = "", buttonSizeImageName: String = "", delegate: GroupSizeContract, bundle: Bundle, rootGroupView: CGFloat, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.iconReferenceName   = iconReferenceName
        self.buttonSizeImageName = buttonSizeImageName
        self.groupSizeType       = groupSizeType
        self.delegate            = delegate
        self.bundle              = bundle
        self.groupViewWidth      = rootGroupView
        
        super.init(frame: frame)
        
        loadGroupPencilSizeButtons()
        
        configureGroupSizeLayout(groupButtons: groupSizeButtons, groupSizeView: self, iconReferenceName: iconReferenceName, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }

    func setIdentifierForView(view: UIView, identifierName: String) {
        view.accessibilityIdentifier = identifierName
    }
    
    private func loadGroupPencilSizeButtons() {
        let buttonSize1   = buildButton(buttonName: "1", sizeTool: 2, buttonWidth: 13, buttonHeight: 13)
        let buttonSize2   = buildButton(buttonName: "2", sizeTool: 5, buttonWidth: 18, buttonHeight: 18)
        let buttonSize3   = buildButton(buttonName: "3", sizeTool: 10, buttonWidth: 23, buttonHeight: 23)
        let buttonSize4   = buildButton(buttonName: "4", sizeTool: 30, buttonWidth: 28, buttonHeight: 28)
        let buttonSize5   = buildButton(buttonName: "5", sizeTool: 55, buttonWidth: 33, buttonHeight: 33)
        let buttonSize6   = buildButton(buttonName: "6", sizeTool: 80, buttonWidth: 37, buttonHeight: 37)

        groupSizeButtons.append(buttonSize1)
        groupSizeButtons.append(buttonSize2)
        groupSizeButtons.append(buttonSize3)
        groupSizeButtons.append(buttonSize4)
        groupSizeButtons.append(buttonSize5)
        groupSizeButtons.append(buttonSize6)
    }
    
    private func buildButton(buttonName: String, sizeTool: Int, buttonWidth: Int, buttonHeight: Int) -> Button {
        let blackHexColor = "#000000"
        let buttonSize    = Button(imageName: "\(buttonSizeImageName)\(buttonName)", imageColor: blackHexColor, selector: #selector(selectSize))
        
        buttonSize.uiButton.tag        = sizeTool
        buttonSize.uiButton.frame.size = CGSize(width: buttonWidth, height: buttonHeight)
        
        return buttonSize
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
        
        centralizeVerticalView(view: groupSizeView, heightBaseToCenter: heightBaseToCenter, xBaseToCenter: xBaseToCenter)
    }
    
    private func configGroupButtonsView(groupButtons: [Button], yReference: CGFloat) -> UIView {
        let groupButtonsView = UIView()
        let origin           = CGPoint(x: 0, y: yReference)
        
        groupButtonsView.frame.origin = origin
        
        configureGroupLayout(buttons: groupButtons, groupView: groupButtonsView, groupViewOirigin: origin)
        
        setButtonsAsNotClicked(buttons: groupButtons)
        
        // Set the second SizeButton as Default
        if groupButtons.indices.contains(1) {
            setButtonSizeAsClicked(button: groupButtons[1].uiButton)
        }

        return groupButtonsView
    }
    
    private func setButtonsAsNotClicked(buttons: [Button]) {
        buttons.forEach { button in
            setButtonSizeAsNotClicked(button: button.uiButton)
        }
    }
    private func setButtonSizeAsClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        
        button.alpha              = 1
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor    = darkGray
    }
    
    private func setButtonSizeAsNotClicked(button: UIButton) {
        let darkGray = UIColor(hex: "606060")
        
        button.alpha              = 0.4
        button.layer.cornerRadius = button.frame.height / 2
        button.backgroundColor    = darkGray
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
        
        let iconImageView  = UIImageView(image: UIImage(named: iconReferenceName, in: bundle, compatibleWith: nil))
        let identifierName = "\(iconReferenceName)SizeReferenceIdentifier"
        
        setIdentifierForView(view: iconImageView, identifierName: identifierName)
        
        iconImageView.frame = frameIconImage
        
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

    private func configureGroupLayout(buttons: [Button], groupView: UIView, groupViewOirigin: CGPoint) {
        for (index, button) in buttons.enumerated() {
            let uiButton = button.uiButton
            let size     = uiButton.frame.size
            
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
        }
        
        let lastUiButton = buttons.last!.uiButton
        
        let height = lastUiButton.frame.origin.y + lastUiButton.frame.height + 20
        let size   = CGSize(width: groupViewWidth, height: height)
        let frame  = CGRect.init(origin: groupViewOirigin, size: size)
        
        groupView.frame              = frame
        groupView.backgroundColor    = backgroundGroupGrayColor
        groupView.layer.cornerRadius = groupView.frame.width / 2
    }
    
    private func addButtonListener(_ button: UIButton, action: Selector) {
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func centralizeVerticalView(view: UIView, heightBaseToCenter: CGFloat, xBaseToCenter: CGFloat) {
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
        
        let x      = (groupViewWidth - size.width) / 2
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
    
    @objc func selectSize(_ sender: UIButton) {
        setButtonsAsNotClicked(buttons: groupSizeButtons)
        setButtonSizeAsClicked(button: sender)
        
        delegate.selectSize(CGFloat(sender.tag), groupSize: groupSizeType)
    }
}
