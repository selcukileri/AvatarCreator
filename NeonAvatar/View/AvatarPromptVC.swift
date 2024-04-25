//
//  AvatarPromptViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import NeonSDK

class AvatarPromptVC: UIViewController, UITextViewDelegate {
    
    let backgroundImage = UIImageView()
    let backButton = UIButton(type: .system)
    let avatarTitleLabel = UILabel()
    let avatarDescriptionLabel = UILabel()
    let avatarIdText = UITextView()
    
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarIdText.delegate = self
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor(hex: 0x0C0C0C)
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor(hex: 0xF5F5F5)
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(3)
            make.width.height.equalTo(50)
        }
        
        backgroundImage.image = UIImage(named: "createavatar")
        backgroundImage.contentMode = .scaleAspectFit
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(280)
            make.width.equalToSuperview()
        }
        
        avatarTitleLabel.text = "Type your avatar prompt"
        avatarTitleLabel.font = Font.custom(size: 28, fontWeight: .SemiBold)
        avatarTitleLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(avatarTitleLabel)
        avatarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        avatarDescriptionLabel.text = "How do you want your avatar looks like?"
        avatarDescriptionLabel.font = Font.custom(size: 16, fontWeight: .Light)
        avatarDescriptionLabel.numberOfLines = 0
        avatarDescriptionLabel.textAlignment = .center
        avatarDescriptionLabel.textColor = UIColor(hex: 0xCCCCCC)
        view.addSubview(avatarDescriptionLabel)
        avatarDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(avatarTitleLabel)
            make.top.equalTo(avatarTitleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview()
        }
        
//        avatarIdText.placeholder = "karenna"
        avatarIdText.returnKeyType = .go
        avatarIdText.textColor = UIColor(hex: 0xEDEDED)
        avatarIdText.backgroundColor = UIColor(hex: 0x2A2A2A)
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: avatarIdText.frame.height))
//        avatarIdText.leftView = paddingView
//        avatarIdText.contentVerticalAlignment = .fill
//        avatarIdText.leftViewMode = .always
        view.addSubview(avatarIdText)
        avatarIdText.snp.makeConstraints { make in
            make.top.equalTo(avatarDescriptionLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(135)
        }
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            
            UserDefaults.standard.set(textView.text, forKey: "avatarPrompt")
            let createVC = CreateVC()
            textView.resignFirstResponder()
            createVC.id = id
            present(destinationVC: createVC, slideDirection: .right)
            return false
        }
        return true
    }
    

}


