//
//  OnBoardingViewController.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 3.04.2024.
//

import UIKit
import NeonSDK

class OnBoardingVC: NeonOnboardingController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        neonConfig()
        
        
    }
    
    func neonConfig(){
        self.configureButton(
            title: "Get Started  ->",
            titleColor: .black,
            font: Font.custom(size: 16, fontWeight: .Bold),
            cornerRadious: 32,
            height: 60,
            horizontalPadding: 40,
            bottomPadding: 0,
            backgroundColor: UIColor(hex: 0x33DB23),
            borderColor: nil,
            borderWidth: nil
        )
        
        self.configureBackground(
            type: .halfBackgroundImage(
                
                backgroundColor: .black,
                offset: 150,
                isFaded: true)
        )
//        let _: () = Font.configureFonts(font: .Poppins)
//        let _: () = Font.configureFonts(font: .Poppins)
        
        self.configureText(titleColor: UIColor(hex: 0xEDEDED), 
                           titleFont: Font.custom(size: 20, fontWeight: .SemiBold),
                           subtitleColor: UIColor(hex: 0x404040),
                           subtitleFont: Font.custom(size: 16, fontWeight: .Light))
        self.addPage(
            title: "Introducing Image AI",
            subtitle: "Create a digital representation of yourself with AI technology",
            image: UIImage(named: "onboarding1")!
        )
        self.addPage(title: "Get Infinite versions of you with AI", subtitle: "Design your avatar with a wide range of customizable features.", image: UIImage(named: "onboarding2")!)
        self.addPage(title: "Turn your words to art", subtitle: "Generate amazing images from basic text prompts", image: UIImage(named: "onboarding3")!)
        self.addPage(title: "Ready to Share", subtitle: "Once you’ve created your images, share them with the world on social media", image: UIImage(named: "onboarding4")!)
    }
    
    override func onboardingCompleted() {
        super.onboardingCompleted()
        let paywallVC = PaywallVC()
        self.present(destinationVC: paywallVC, slideDirection: .up)
    }
//    
//        override func onboardingCompleted() {
//            //super.onboardingCompleted()
//            let homeVC = HomeVC()
//            self.present(destinationVC: homeVC, slideDirection: .up)
//        }
//    
}
