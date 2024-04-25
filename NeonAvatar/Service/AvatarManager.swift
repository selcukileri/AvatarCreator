//
//  NetworkManager.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 6.04.2024.
//

import UIKit

enum AvatarError: Error {
    case serverError
    case parsingError
}

class AvatarManager {
    
    static let shared = AvatarManager()
    private let baseURL = "https://api.openai.com/v1/images/generations"
    let apiKey = Constants.apiKey
    
    private init() {}
    
    func getAvatars(prompt: String, size: String, completion: @escaping (Result<Avatars, AvatarError>) -> () ) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(.serverError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String : Any] = [
            "model": "dall-e-3",
            "prompt" : prompt,
            "size" : size,
            //"max_tokens" : 50,
            "n" : 1
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
            completion(.failure(.serverError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                completion(.failure(.parsingError))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let data = jsonResponse["data"] as? [[String: Any]],
                   let firstImage = data.first,
                   let imageUrl = firstImage["url"] as? String {
                    let avatars = Avatars(avatarName: "test", avatarImage: imageUrl)
                    completion(.success(avatars))
                    print("url: \(imageUrl)")
                } else {
                    print(error?.localizedDescription)
                    completion(.failure(.parsingError))
                }
            } catch {
                print("errorCatch: \(error.localizedDescription)")
                completion(.failure(.serverError))
            }
            
        }
        task.resume()
        
    }
}
