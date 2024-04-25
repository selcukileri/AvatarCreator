//
//  PremiumViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 6.04.2024.
//

import UIKit

class PremiumVC: UIViewController {
    
    let backButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor(hex: 0xF5F5F5)
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(3)
            make.width.height.equalTo(50)
        }
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }

}
