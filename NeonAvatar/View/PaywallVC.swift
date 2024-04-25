//
//  PaywallViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import NeonSDK

class PaywallVC: UIViewController, RevenueCatManagerDelegate {
    
    let featuresView = NeonPaywallFeaturesView()
    let planLabel = UILabel()
    let continueButton = UIButton()
    let cancelLabel = UILabel()
    let legalView = NeonLegalView()
    let exitButton = UIButton()
    let containerView = UIView()
    let saveLabel = UILabel()
    let yearlyAccessLabel = UILabel()
    let priceLabel = UILabel()
    
    var isBackgroundChanged = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        RevenueCatManager.delegate = self
        setupUI()
        packageFetched()
    }
    
    func setupUI(){
        
        view.backgroundColor = .black
        
        if let backgroundImage = UIImage(named: "paywallbackground") {
            let backgroundImageView = UIImageView(image: backgroundImage)
            view.addSubview(backgroundImageView)
            backgroundImageView.snp.makeConstraints { make in
                make.top.left.right.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview().multipliedBy(0.8)
                
            }
            
            exitButton.setImage(UIImage(named: "exit"), for: .normal)
            exitButton.addTarget(self, action: #selector(exitClicked), for: .touchUpInside)
            view.addSubview(exitButton)
            exitButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
                make.trailing.equalToSuperview().offset(-10)
                make.height.width.equalTo(50)
            }
            
            
            planLabel.text = "Choose Your Plan"
            planLabel.textColor = .white
            planLabel.font = Font.custom(size: 28, fontWeight: .Bold)
            view.addSubview(planLabel)
            planLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(250)
                make.horizontalEdges.equalToSuperview().inset(60)
                make.height.equalTo(42)
            }
            
            featuresView.featureTextColor = .white
            featuresView.featureIconBackgroundColor = .black
            featuresView.featureIconTintColor = .white
            featuresView.addFeature(title: "Unlimited Art Creation", icon: UIImage(named: "paywall1")!)
            featuresView.addFeature(title: "Ad - Free Experience", icon: UIImage(named: "paywall2")!)
            featuresView.addFeature(title: "No limits to Photo Editing", icon: UIImage(named: "paywall3")!)
            view.addSubview(featuresView)
            featuresView.snp.makeConstraints { make in
                make.top.equalTo(planLabel.snp.bottom).offset(80)
                make.horizontalEdges.equalToSuperview().inset(30)
            }

            containerView.backgroundColor = .black
            containerView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(containerClicked))
            containerView.addGestureRecognizer(gestureRecognizer)
            containerView.layer.cornerRadius = 10
            containerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(containerView)
            
            containerView.snp.makeConstraints { make in
                make.top.equalTo(featuresView.snp.bottom).offset(60)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(130)
            }

            saveLabel.text = "SAVE %60"
            saveLabel.textColor = .green
            saveLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            saveLabel.backgroundColor = .black
            saveLabel.textAlignment = .right
            saveLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(saveLabel)
            
            saveLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(10)
            }
            
            yearlyAccessLabel.text = "YEARLY ACCESS"
            yearlyAccessLabel.textColor = .systemGreen
            yearlyAccessLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
            yearlyAccessLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(yearlyAccessLabel)
            
            yearlyAccessLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.top.equalToSuperview().offset(10)
                make.trailing.equalTo(saveLabel.snp.trailing).offset(-10)
            }

//            priceLabel.text = "US$29.99/year"
            priceLabel.textColor = .white
            priceLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
            priceLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(priceLabel)
            
            priceLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                make.trailing.equalToSuperview().offset(-10)
                make.top.equalTo(yearlyAccessLabel.snp.bottom).offset(2)
            }
            
            continueButton.setTitle("Continue", for: .normal)
            continueButton.setTitleColor(UIColor(hex: 0x0C0C0C), for: .normal)
            continueButton.backgroundColor = UIColor(hex: 0x33DB23)
            continueButton.titleLabel?.font = Font.custom(size: 24, fontWeight: .Bold)
            continueButton.layer.cornerRadius = 32
            continueButton.titleLabel?.textAlignment = .center
            continueButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .Medium)
            continueButton.addTarget(self, action: #selector(continueClicked), for: .touchUpInside)
            view.addSubview(continueButton)
            continueButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
                make.horizontalEdges.equalToSuperview().inset(30)
                make.height.equalTo(70)
            }
            
            cancelLabel.text = "No commitment. Cancel anytime."
            cancelLabel.textColor = .white
            cancelLabel.font = Font.custom(size: 14, fontWeight: .Light)
            view.addSubview(cancelLabel)
            cancelLabel.snp.makeConstraints { make in
                make.bottom.equalTo(continueButton.snp.top).offset(-20)
                make.centerX.equalToSuperview()
            }
            
            
        }
        
        
        
        
        
    }
    
    @objc func containerClicked(){
        if isBackgroundChanged {
            containerView.backgroundColor = UIColor.systemBlue
            continueButton.isEnabled = true
            subsClicked()
        } else {
            containerView.backgroundColor = UIColor.black
            continueButton.isEnabled = false
        }
        
        isBackgroundChanged = !isBackgroundChanged
    }
    
    @objc func continueClicked(){
//        if isBackgroundChanged {
            //satin alim islemi
            RevenueCatManager.purchase(animation: .loadingBar) {
                let vc = CollectionVC()
                self.present(destinationVC: vc, slideDirection: .right)
            } completionFailure: {
                print("error")
            }

            
            
//        }
    }
    
    @objc func exitClicked(){
        let collectionVC = CollectionVC()
        present(destinationVC: collectionVC, slideDirection: .up)
    }
    
    func subsClicked() {
        print("subs Clicked")
        print("subs clicked")
        RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual")
    }
    
    func packageFetched(){
        
        if let price = RevenueCatManager.getPackagePrice(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual") {
            print("price: \(price)")
            priceLabel.text = "price: \(price)"
        
        }
        if let annualPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual"){
            let price = annualPackage.localizedPriceString
            print("price: \(price)")
        }
    }
}
