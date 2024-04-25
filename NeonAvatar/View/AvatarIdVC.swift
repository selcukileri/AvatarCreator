//
//  CreateAvatarViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import NeonSDK
import CoreData

class AvatarIdVC: UIViewController, UITextFieldDelegate {
    
    let viewModel = AvatarIdViewModel()
    
    let backgroundImage = UIImageView()
    let backButton = UIButton(type: .system)
    let avatarTitleLabel = UILabel()
    let avatarDescriptionLabel = UILabel()
    let avatarIdText = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarIdText.delegate = self
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
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
        
        avatarTitleLabel.text = "Type Your Avatar ID"
        avatarTitleLabel.font = Font.custom(size: 28, fontWeight: .SemiBold)
        avatarTitleLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(avatarTitleLabel)
        avatarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        avatarDescriptionLabel.text = "What will you call your avatar?"
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
        
        avatarIdText.placeholder = "karenna"
        avatarIdText.returnKeyType = .go
        avatarIdText.textColor = UIColor(hex: 0xEDEDED)
        avatarIdText.backgroundColor = UIColor(hex: 0x2A2A2A)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: avatarIdText.frame.height))
        avatarIdText.leftView = paddingView
        avatarIdText.leftViewMode = .always
        view.addSubview(avatarIdText)
        avatarIdText.snp.makeConstraints { make in
            make.top.equalTo(avatarDescriptionLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let avatarId = avatarIdText.text, viewModel.validateAvatarId(avatarId) {
            let avatarPromptVC = AvatarPromptVC()
            avatarPromptVC.id = avatarId
            present(destinationVC: avatarPromptVC, slideDirection: .right)
        } else {
            makeAlert(title: "Oops!", message: "Avatar ID must be between 4 and 20 characters.")
        }
        return true
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
