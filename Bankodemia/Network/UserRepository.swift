//
//  UserRepository.swift
//  Bankodemia
//
//  Created by javier pineda on 12/11/26.
//

import Foundation
import FirebaseFirestore

protocol UserRepositoryProtocol {
    func save(_ user: UserProfile) async throws
    func fetch(userId: String) async throws -> UserProfile?
}

final class UserRepository: UserRepositoryProtocol {
    private let collection: CollectionReference
    
    init(db: Firestore = Firestore.firestore()) {
        self.collection = db.collection("users")
    }
    
    func save(_ user: UserProfile) async throws {
        var data: [String: Any] = [
            "name": user.name,
            "email": user.email,
            "lastName": user.lastName,
            "phone": user.phone,
            "userName": user.userName,
            "bornDate": Timestamp(date: user.bornDate),
            "genre": user.genre.rawValue
        ]
        
        do {
            try await collection.document(user.id).setData(data, merge: true)
        } catch {
            throw UserRepositoryError.saveFailed
        }
    }
    
    func fetch(userId: String) async throws -> UserProfile? {
        do {
            let snapShot = try await collection.document(userId).getDocument()
            guard let data = snapShot.data() else {
                return nil
            }
            
            return UserProfile(id: userId,
                               name: data["name"] as? String ?? "",
                               email: data["email"] as? String ?? "",
                               lastName: data["lastName"] as? String ?? "",
                               userName: data["userName"] as? String ?? "",
                               phone: data["phone"] as? String ?? "",
                               bornDate: (data["bornDate"] as? Timestamp)?.dateValue() ?? Date(),
                               genre: UserGenre(rawValue: data["genre"] as? String ?? "") ?? .male)
        } catch {
            throw UserRepositoryError.loadFailed
        }
    }
}
