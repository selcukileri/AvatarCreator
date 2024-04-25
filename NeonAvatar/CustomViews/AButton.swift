//
//  AButton.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 5.04.2024.
//

import UIKit
import NeonSDK

protocol NavigationDelegate {
    func navigateToVC(navigationVC: UIViewController)
}

enum AButtonType {
    case premium
    case restore
    case privacy
    case termOfUse
    case rateUs
}

class AButton : UIButton {
    
    var navigationDelegate: NavigationDelegate?
    var itemType: AButtonType!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, itemType: AButtonType) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.itemType = itemType
    }
    
    func configure(){
        
        setTitleColor(UIColor(hex: 0xEAEAEA), for: .normal)
        backgroundColor = UIColor(hex: 0x2A2A2A)
        titleLabel?.font = Font.custom(size: 15, fontWeight: .Bold)
        //titleLabel?.font = UIFont.systemFont(ofSize: 15)
        contentHorizontalAlignment = .leading
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        layer.cornerRadius = 5
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    
    @objc func buttonPressed(){
        switch itemType {
        case .premium:
            if let delegate = navigationDelegate {
                let premiumVC = PaywallVC()
                delegate.navigateToVC(navigationVC: premiumVC)
            }
            print("premium")
        case .restore:
            if let delegate = navigationDelegate {
                let restoreVC = RestorePurchaseVC()
                delegate.navigateToVC(navigationVC: restoreVC)
            }
            print("Restore")
        case .privacy:
            if let delegate = navigationDelegate {
                let privacyVC = PrivacyVC()
                delegate.navigateToVC(navigationVC: privacyVC)
            }
            print("Privacy")
        case .termOfUse:
            if let delegate = navigationDelegate {
                let termOfUseVC = TermOfUseVC()
                delegate.navigateToVC(navigationVC: termOfUseVC)
            }
            print("termOfUse")
        case .rateUs:
            if let delegate = navigationDelegate {
                let rateVC = RateVC()
                delegate.navigateToVC(navigationVC: rateVC)
            }
            print("Rate Us")
        case .none:
            print("0")
        }
    }
}
