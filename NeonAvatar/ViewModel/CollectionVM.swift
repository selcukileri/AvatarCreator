//
//  CollectionVM.swift
//  NeonAvatar
//
//  Created by Selçuk İleri on 18.04.2024.
//

import CoreData
import UIKit
import RxSwift
import RxCocoa

class CollectionVM {
    
    private var avatarList : [Avatarss] = []
    private var avatarListSubject = BehaviorSubject<[Avatarss]>(value: [])
    var avatarListObservable: Observable<[Avatarss]> {
        return avatarListSubject.asObservable()
    }
    
    func fetchAvatarList() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            avatarListSubject.onNext([])
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Avatarss>(entityName: "Avatarss")
        
        do {
            let fetchedAvatars = try context.fetch(fetchRequest)
            self.avatarList = fetchedAvatars
            avatarListSubject.onNext(fetchedAvatars)
        } catch {
            print("Error fetching avatars from Core Data: \(error.localizedDescription)")
            avatarListSubject.onNext([])
        }
    }
    
    func deleteAllAvatars(completion: @escaping (Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            completion(false)
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Avatarss")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(true)
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
            completion(false)
        }
    }
}
