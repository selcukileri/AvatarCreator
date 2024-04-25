//
//  AvatarIdVM.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 18.04.2024.
//

import Foundation

class AvatarIdViewModel {
    func validateAvatarId(_ avatarId: String?) -> Bool {
        guard let avatarId = avatarId else { return false }
        
        let idLength = avatarId.count
        if idLength < 4 || idLength > 20 {
            return false
        }
                
        return true
    }
}
