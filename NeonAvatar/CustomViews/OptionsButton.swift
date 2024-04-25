//
//  OptionsButton.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 7.04.2024.
//

import UIKit
import NeonSDK

class OptionsButton : UIButton {
    
    enum ButtonType2 {
        case square
        case landscape
        case portrait
        case none
    }
    
    private var isState = false
    var buttonType2: ButtonType2 = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        setTitleColor(UIColor(hex: 0xF5F5F5), for: .normal)
        backgroundColor = UIColor(hex: 0x404040)

        titleLabel?.font = Font.custom(size: 12, fontWeight: .Bold)
        //titleLabel?.font = UIFont.systemFont(ofSize: 12)
        contentHorizontalAlignment = .leading
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layer.cornerRadius = 15
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
    }
    
    func toggleState() {
        isState.toggle()
        updateAppearance()
    }
    
    func resetState() {
        isState = false
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isState {
            setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
            backgroundColor = UIColor(hex: 0x33DB23)
        } else {
            setTitleColor(UIColor(hex: 0xF5F5F5), for: .normal)
            backgroundColor = UIColor(hex: 0x404040)
        }
    }
    
    @objc func buttonClicked(){
        toggleState()
        if let createVC = self.findViewController() as? CreateVC {
            createVC.resetOtherButtonsState(self)
            createVC.resetAspectButtonsState(self)
            if isState {
                switch self.buttonType2 {
                case .square, .landscape, .portrait:
                    break
                case .none:
                    createVC.promptText.text = self.currentTitle
                }
            }
            if isState {
                switch self.buttonType2 {
                case .square:
                    createVC.choosenSize = "1024x1024"
                case .landscape:
                    createVC.choosenSize = "1024x1792"
                case .portrait:
                    createVC.choosenSize = "1792x1024"
                default:
                    break
                }
            }
        }
    }
}

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        }
        if let next = self.next {
            return next.findViewController()
        }
        return nil
    }
}
