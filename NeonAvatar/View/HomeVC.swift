//
//  Home2ViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 8.04.2024.
//

import UIKit
import NeonSDK

class HomeVC: UIViewController {
    
    let titleLabel = UILabel()
    let settingsIcon = UIButton()
    let startLabel = UILabel()
    let backButton = UIButton(type: .system)
    let descriptionLabel = UILabel()
    let arrow = UIImageView()
    let createButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

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

        titleLabel.text = "Create Avatar"
        titleLabel.font = Font.custom(size: 20, fontWeight: .SemiBold)
        titleLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        settingsIcon.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsIcon.tintColor = UIColor(hex: 0xF5F5F5)
        settingsIcon.addTarget(self, action: #selector(settingsClicked), for: .touchUpInside)
        view.addSubview(settingsIcon)
        settingsIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(50)
        }
        
        view.addSubview(settingsIcon)
        
        startLabel.text = "Start Here"
        startLabel.font = Font.custom(size: 28, fontWeight: .SemiBold)
        startLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(startLabel)
        startLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        }
        
        descriptionLabel.text = "Create your first avatar with the      power of artificial intelligence."
        descriptionLabel.font = Font.custom(size: 16, fontWeight: .Light)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(hex: 0xB5B5B5)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(startLabel)
            make.top.equalTo(startLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(70)
        }
        
        arrow.image = UIImage(named: "arrow1")
        arrow.contentMode = .scaleAspectFit
        arrow.tintColor = UIColor(hex: 0xF5F5F5)
        view.addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.centerX.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
        }
        
        createButton.setTitle("Create New Avatar", for: .normal)
        createButton.setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
        createButton.backgroundColor = UIColor(hex: 0x33DB23)
        createButton.layer.cornerRadius = 15
        createButton.titleLabel?.textAlignment = .center
        createButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Medium)
        createButton.addTarget(self, action: #selector(createClicked), for: .touchUpInside)
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(arrow.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
    }
    
    @objc func createClicked(){
        let avatarIdVC = AvatarIdVC()
        present(destinationVC: avatarIdVC, slideDirection: .right)
    }
    
    @objc func settingsClicked(){
        let settingsVC = SettingsVC()
        present(destinationVC: settingsVC, slideDirection: .right)
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }

}
