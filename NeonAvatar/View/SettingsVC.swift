//
//  SettingsViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import SnapKit
import NeonSDK

class SettingsVC: UIViewController, NavigationDelegate {
    
    func navigateToVC(navigationVC: UIViewController) {
        present(destinationVC: navigationVC, slideDirection: .right)
    }
    
    
    let settingsLabel = UILabel()
    let backButton = UIButton(type: .system)
    let premiumButton = AButton(title: "Try Premium", itemType: .premium)
    let restoreButton = AButton(title: "Restore Purchase", itemType: .restore)
    let privacyButton = AButton(title: "Privacy Policy", itemType: .privacy)
    let termOfUseButton = AButton(title: "Term of Use", itemType: .termOfUse)
    let rateButton = AButton(title: "Rate", itemType: .rateUs)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        
        premiumButton.navigationDelegate = self
        restoreButton.navigationDelegate = self
        privacyButton.navigationDelegate = self
        termOfUseButton.navigationDelegate = self
        rateButton.navigationDelegate = self
        view.backgroundColor = UIColor(hex: 0x0C0C0C)
        
        settingsLabel.text = "Settings"
        settingsLabel.font = Font.custom(size: 28, fontWeight: .SemiBold)
        settingsLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor(hex: 0xF5F5F5)
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(3)
            make.width.height.equalTo(50)
        }
        let premiumIcon = UIButton()
        premiumIcon.setImage(UIImage(named: "premium"), for: .normal)
        premiumIcon.tintColor = UIColor(hex: 0x0C0C0C)
        
        premiumButton.setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
        premiumButton.backgroundColor = UIColor(hex: 0x33DB23)

        view.addSubview(premiumButton)
        premiumButton.addSubview(premiumIcon)
        
        premiumIcon.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(10)
            
        }
        
        premiumButton.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(31)
            make.height.equalTo(50)
        }
        
        view.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(premiumButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(31)
            make.height.equalTo(50)
        }
        

        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(restoreButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(31)
            make.height.equalTo(50)
        }
        
        view.addSubview(termOfUseButton)
        termOfUseButton.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(31)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(rateButton)
        rateButton.snp.makeConstraints { make in
            make.top.equalTo(termOfUseButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(31)
            make.height.equalTo(50)
        }
        
        
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }

}
