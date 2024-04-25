//
//  ResultViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 4.04.2024.
//

import UIKit
import NeonSDK
import CoreData

class ResultVC: UIViewController {
    
    let backButton = UIButton()
    let shareButton = UIButton()
    let avatarImageView = UIImageView()
    let avatarIdLabel = UILabel()
    let prompTextView = UITextView()
    let saveButton = UIButton()
    let refreshButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()
    let overlayView = UIView()
    
    var choosenSize: String?
    var id2: String?
    
    var imageURL: String
    
    
    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0x0C0C0C)
        // Do any additional setup after loading the view.
        setupUI()
        loadImage()
        getData()
    }
    
    func setupUI(){
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor(hex: 0xF5F5F5)
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(3)
            make.width.height.equalTo(50)
        }
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = UIColor(hex: 0xF5F5F5)
        shareButton.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(50)
        }
        
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 25
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.width.height.equalTo(380)
            make.left.right.equalToSuperview().inset(20)
        }
        
        //avatarIdLabel.text = "Avatar ID: \()"
        avatarIdLabel.font = Font.custom(size: 24, fontWeight: .SemiBold)
        avatarIdLabel.textColor = UIColor(hex: 0xFFFFFF)
        view.addSubview(avatarIdLabel)
        avatarIdLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        let savedPrompt = UserDefaults.standard.string(forKey: "avatarPrompt")
        prompTextView.text = savedPrompt
        prompTextView.returnKeyType = .default
        prompTextView.textColor = UIColor(hex: 0xEDEDED)
        prompTextView.backgroundColor = UIColor(hex: 0x2A2A2A)
        prompTextView.layer.cornerRadius = 25
        view.addSubview(prompTextView)
        prompTextView.snp.makeConstraints { make in
            make.top.equalTo(avatarIdLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(138)
        }
        
        let downloadIcon = UIImage(systemName: "square.and.arrow.down")
        
        saveButton.setImage(downloadIcon, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = UIColor(hex: 0x0C0C0C)
        saveButton.setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
        saveButton.backgroundColor = UIColor(hex: 0x33DB23)
        saveButton.layer.cornerRadius = 8
        saveButton.titleLabel?.textAlignment = .center
        saveButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Medium)
        saveButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(prompTextView.snp.bottom).offset(20)
            make.left.equalTo(prompTextView)
            make.width.equalToSuperview().dividedBy(2.3)
            make.height.equalTo(50)
        }
        let refreshIcon = UIImage(named: "refresh")
        refreshButton.setImage(refreshIcon, for: .normal)
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.tintColor = UIColor(hex: 0xF5F5F5)
        refreshButton.setTitleColor(UIColor(hex: 0xF5F5F5), for: .normal)
        refreshButton.backgroundColor = UIColor(hex: 0x0C0C0C)
        refreshButton.layer.cornerRadius = 8
        refreshButton.titleLabel?.textAlignment = .center
        refreshButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Medium)
        refreshButton.addTarget(self, action: #selector(refreshClicked), for: .touchUpInside)
        view.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.centerY.equalTo(saveButton)
            make.left.equalTo(saveButton.snp.right).offset(5)
            make.right.equalTo(-15)
            make.width.equalToSuperview().dividedBy(2.3)
            make.height.equalTo(50)
        }
        
        activityIndicator.isHidden = true
        activityIndicator.style = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    func loadImage() {
        guard let url = URL(string: imageURL) else {
            print("Invalid image URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            } else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    @objc func refreshClicked(){
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        guard let promptText = prompTextView.text else {
            makeAlert(title: "Ooops", message: "Pls enter a prompt")
            return
        }
        AvatarManager.shared.getAvatars(prompt: promptText, size: choosenSize!) { result in
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
    
    @objc func saveClicked(){
        guard let imageToSave = avatarImageView.image else {
            print("No image to save")
            return
        }
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        } else {
            makeAlert(title: "Success", message: "Image saved successfully.")
            
        }
    }
    
    @objc func backClicked(){
        let collectionVC = CollectionVC()
        present(destinationVC: collectionVC, slideDirection: .down)
    }
    
    @objc func shareClicked(){
        
        let fileURL = URL(fileURLWithPath: "path/to/your/file")
        let image = avatarImageView.image
        
        if let image = image {
            let activityViewController = UIActivityViewController(activityItems: [fileURL, image], applicationActivities: nil)
            activityViewController.title = "Share"
            present(activityViewController, animated: true)
        }
        
    }
    
    func getData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Avatarss")
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                if let avatarId = result.value(forKey: "avatarId") as? String {
                    avatarIdLabel.text = "Avatar ID: \(avatarId)"
                    
                    if let avatarImage = result.value(forKey: "avatarImage") as? String {
                        avatarImageView.image = UIImage(named: avatarImage)
                    }
                }
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func saveImageToCoreData(imageURL: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let newAvatarImage = NSEntityDescription.insertNewObject(forEntityName: "Avatarss", into: context) as! Avatarss
        
        newAvatarImage.avatarImage = imageURL
        newAvatarImage.avatarId = id2
        
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

