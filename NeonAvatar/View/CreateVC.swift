//
//  CreateViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import NeonSDK
import CoreData

class CreateVC: UIViewController, UITextViewDelegate {
        
    let createTitleLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    let overlayView = UIView()
    let createLabel = UILabel()
    let backButton = UIButton(type: .system)
    let promptText = UITextView()
    let prompSuggestions = ["A fluffy white kitten playing with a ball of yarn.",
                            "A curious tabby cat exploring a sunlit garden.",
                            "Two adorable kittens cuddled up together in a cozy bed.",
                            "A mischievous black cat peeking out from behind a curtain.",
                            "A majestic Maine Coon cat lounging on a tree branch.",
                            "An elegant Siamese cat posing gracefully on a windowsill."]
    
    let menuView = UIView()
    let option1Button = OptionsButton()
    let option2Button = OptionsButton()
    let option3Button = OptionsButton()
    let option4Button = OptionsButton()
    let option5Button = OptionsButton()
    let option6Button = OptionsButton()
    let chooseRatioLabel = UILabel()
    
    let menuRatio = UIView()
    let squareButton = OptionsButton()
    let landscapeButton = OptionsButton()
    let portraitButton = OptionsButton()
    
    let menuButton = UIButton()
    let arrowImageView = UIImageView()
    let createMoreButton = UIButton(type: .system)
    var choosenSize: String = ""
    
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promptText.delegate = self
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    private func setupUI(){
        view.backgroundColor = UIColor(hex: 0x0C0C0C)
        
        createTitleLabel.text = "Create Avatar"
        createTitleLabel.font = Font.custom(size: 20, fontWeight: .SemiBold)
        createTitleLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(createTitleLabel)
        createTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
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
        
        createLabel.text = "Create:"
        createLabel.font = Font.custom(size: 14, fontWeight: .SemiBold)
        createLabel.textColor = UIColor(hex: 0xEDEDED)
        view.addSubview(createLabel)
        createLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(50)
        }
        let savedPrompt = UserDefaults.standard.string(forKey: "avatarPrompt")
        promptText.text = savedPrompt
        promptText.returnKeyType = .default
        promptText.textColor = UIColor(hex: 0xEDEDED)
        promptText.backgroundColor = UIColor(hex: 0x2A2A2A)
        promptText.layer.cornerRadius = 25
        view.addSubview(promptText)
        promptText.snp.makeConstraints { make in
            make.top.equalTo(createLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(135)
        }
        
        menuButton.setTitle("Promp Suggestions", for: .normal)
        menuButton.contentHorizontalAlignment = .leading
        menuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        menuButton.layer.cornerRadius = 17
        menuButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.top.equalTo(promptText.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        menuView.backgroundColor = UIColor(hex: 0x2A2A2A)
        menuView.isHidden = true
        menuView.clipsToBounds = true
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.leading.equalTo(menuButton.snp.leading)
            make.height.equalTo(150)
            make.top.equalTo(menuButton.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        
        option1Button.setTitle(prompSuggestions[0], for: .normal)
        option1Button.buttonType2 = .none
        menuView.addSubview(option1Button)
        option1Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        option2Button.setTitle(prompSuggestions[1], for: .normal)
        option2Button.buttonType2 = .none
        menuView.addSubview(option2Button)
        option2Button.snp.makeConstraints { make in
            make.top.equalTo(option1Button.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        option3Button.setTitle(prompSuggestions[2], for: .normal)
        option3Button.buttonType2 = .none
        menuView.addSubview(option3Button)
        option3Button.snp.makeConstraints { make in
            make.top.equalTo(option2Button.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        option4Button.setTitle(prompSuggestions[3], for: .normal)
        option4Button.buttonType2 = .none
        menuView.addSubview(option4Button)
        option4Button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(option1Button.snp.right).offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        option5Button.setTitle(prompSuggestions[4], for: .normal)
        option5Button.buttonType2 = .none
        menuView.addSubview(option5Button)
        option5Button.snp.makeConstraints { make in
            make.top.equalTo(option4Button.snp.bottom).offset(10)
            make.left.equalTo(option2Button.snp.right).offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        option6Button.setTitle(prompSuggestions[5], for: .normal)
        option6Button.buttonType2 = .none
        menuView.addSubview(option6Button)
        option6Button.snp.makeConstraints { make in
            make.top.equalTo(option5Button.snp.bottom).offset(10)
            make.left.equalTo(option3Button.snp.right).offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        chooseRatioLabel.text = "Choose Aspect Ratio"
        chooseRatioLabel.font = Font.custom(size: 14, fontWeight: .Bold)
        chooseRatioLabel.textColor = UIColor(hex: 0xF5F5F5)
        view.addSubview(chooseRatioLabel)
        chooseRatioLabel.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        menuRatio.backgroundColor = UIColor(hex: 0x0C0C0C)
        menuRatio.layer.cornerRadius = 15
        menuRatio.clipsToBounds = true
        view.addSubview(menuRatio)
        menuRatio.snp.makeConstraints { make in
            make.top.equalTo(chooseRatioLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        squareButton.setImage(UIImage(named: "square"),for: .normal)
        squareButton.setTitle("Square", for: .disabled)
        squareButton.buttonType2 = .square
        squareButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        squareButton.layer.cornerRadius = 15
        menuRatio.addSubview(squareButton)
        squareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        squareButton.imageView?.contentMode = .scaleAspectFit
        squareButton.contentHorizontalAlignment = .center
        squareButton.contentVerticalAlignment = .center
        
        landscapeButton.setImage(UIImage(named: "yatay"),for: .normal)
        landscapeButton.buttonType2 = .landscape
        landscapeButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        landscapeButton.setTitle("Landscape", for: .disabled)
        landscapeButton.layer.cornerRadius = 15
        menuRatio.addSubview(landscapeButton)
        landscapeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(squareButton.snp.right).offset(20)
            make.height.equalTo(100)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        landscapeButton.imageView?.contentMode = .scaleAspectFit
        landscapeButton.contentHorizontalAlignment = .center
        landscapeButton.contentVerticalAlignment = .center
        
        portraitButton.setImage(UIImage(named: "dik"),for: .normal)
        portraitButton.buttonType2 = .portrait
        portraitButton.backgroundColor = UIColor(hex: 0x2A2A2A)
        portraitButton.setTitle("Portrait", for: .disabled)
        portraitButton.layer.cornerRadius = 15
        menuRatio.addSubview(portraitButton)
        portraitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(landscapeButton.snp.right).offset(20)
            make.height.equalTo(100)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        portraitButton.imageView?.contentMode = .scaleAspectFit
        portraitButton.contentHorizontalAlignment = .center
        portraitButton.contentVerticalAlignment = .center
        
        arrowImageView.image = UIImage(systemName: "arrow.down")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .white
        
        menuButton.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        
        
        createMoreButton.setTitle("Create More", for: .normal)
        createMoreButton.setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
        createMoreButton.backgroundColor = UIColor(hex: 0x33DB23)
        createMoreButton.layer.cornerRadius = 15
        createMoreButton.titleLabel?.textAlignment = .center
        createMoreButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Medium)
        createMoreButton.addTarget(self, action: #selector(createClicked), for: .touchUpInside)
        view.addSubview(createMoreButton)
        createMoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        activityIndicator.isHidden = true
        activityIndicator.style = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    func resetOtherButtonsState(_ selectedButton: OptionsButton) {
        let allButtons: [OptionsButton] = [option1Button, option2Button, option3Button, option4Button, option5Button, option6Button]
        
        for button in allButtons {
            if button != selectedButton {
                button.resetState()
            }
        }
    }
    
    func resetAspectButtonsState(_ selectedButton: OptionsButton) {
        let allButtons: [OptionsButton] = [landscapeButton, squareButton, portraitButton]
        
        for button in allButtons {
            if button != selectedButton {
                button.resetState()
            }
        }
    }
    
    @objc func openMenu() {
        
        menuView.isHidden = !menuView.isHidden
        if menuView.isHidden {
            arrowImageView.image = UIImage(systemName: "arrow.down")
            chooseRatioLabel.snp.updateConstraints { make in
                make.top.equalTo(menuButton.snp.bottom).offset(5)
            }
            menuRatio.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
            landscapeButton.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
            squareButton.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
            portraitButton.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
        } else {
            menuRatio.snp.updateConstraints { make in
                make.height.equalTo(70)
            }
            landscapeButton.snp.updateConstraints { make in
                make.height.equalTo(70)
            }
            squareButton.snp.updateConstraints { make in
                make.height.equalTo(70)
            }
            portraitButton.snp.updateConstraints { make in
                make.height.equalTo(70)
            }
            chooseRatioLabel.snp.updateConstraints { make in
                make.top.equalTo(menuButton.snp.bottom).offset(150)
            }
            arrowImageView.image = UIImage(systemName: "arrow.up.trash")
        }
    }
    
    @objc func createClicked() {
        if choosenSize.isEmpty {
            self.makeAlert(title: "Ooops!", message: "Please select size")
            return
        }

        print("size: \(choosenSize)")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        guard let newPrompt = promptText.text else {
            return
        }
        
        UserDefaults.standard.set(newPrompt, forKey: "avatarPrompt")
        
        
        AvatarManager.shared.getAvatars(prompt: newPrompt, size: choosenSize) { result in
            switch result {
            case .success(let avatar):
                DispatchQueue.main.async {
                    let resultVC = ResultVC(imageURL: avatar.avatarImage)
                    resultVC.choosenSize = self.choosenSize
                    
                    self.saveImageToCoreData(imageURL: avatar.avatarImage)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.overlayView.removeFromSuperview()
                    self.present(resultVC, animated: true, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.makeAlert(title: "Error", message: "Try again later... ")
                }
                print("Avatar oluşturma hatası: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
    }
    
    func saveImageToCoreData(imageURL: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let newAvatarImage = NSEntityDescription.insertNewObject(forEntityName: "Avatarss", into: context) as! Avatarss
        
        newAvatarImage.avatarImage = imageURL
        newAvatarImage.avatarId = id
        let resultVC = ResultVC(imageURL: imageURL)
        resultVC.id2 = self.id
        print("id: \(id)")
        
        
        do {
            try context.save()
            print("saved imageURL: \(imageURL)")
        } catch {
            print("error saving: \(error.localizedDescription)")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
