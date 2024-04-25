//
//  AvatarCollectionViewCell.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 4.04.2024.
//

import UIKit
import SnapKit
import SDWebImage

class AvatarCell: UICollectionViewCell {
    
    var currentAvatarId: String?
    static let reuseID = "AvatarCell"
    let avatarImageView = UIImageView()
    let avatarLabel = UILabel()
    let placeholderImage = UIImage(systemName: "checkmark.applewatch")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(avatar: Avatarss) {
        self.avatarLabel.text = avatar.avatarId
        self.currentAvatarId = avatar.avatarId
        print("avatar image : \(avatar.avatarImage)")
        print("avatar id: \(avatar.avatarId)")
        DispatchQueue.main.async {
            if let imageUrlString = avatar.avatarImage?.trimmingCharacters(in: CharacterSet(charactersIn: "\"")), let url = URL(string: imageUrlString) {
                print("avatarImage URL: \(imageUrlString)")
                self.avatarImageView.sd_setImage(with: url, placeholderImage: self.placeholderImage) { [weak self] image, error, cacheType, imageUrl in
                    guard let self = self else { return }
                    if self.currentAvatarId == avatar.avatarId {
                        if let error = error {
                            print("Resim yüklenirken hata oluştu: \(error.localizedDescription)")
                        } else {
                            self.avatarLabel.text = avatar.avatarId
                            self.avatarImageView.image = image
                        }
                    }
                }
            } else {
                self.avatarImageView.image = UIImage(systemName: "square.and.arrow.up.badge.clock.fill")
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        avatarLabel.text = nil
    }
    
    private func configure(){
        avatarLabel.textColor = UIColor(hex: 0xF5F5F5)
        avatarImageView.contentMode = .scaleAspectFit
        
        addSubview(avatarImageView)
        addSubview(avatarLabel)
        let padding: CGFloat = 8
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(120)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(padding)
            make.height.equalTo(50)
        }
    }
}
