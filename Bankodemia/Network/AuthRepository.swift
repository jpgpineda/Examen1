//
//  AuthRepository.swift
//  Bankodemia
//
//  Created by Javier OnTop on 03/11/26.
//

import Foundation
import FirebaseAuth

protocol AuthRepositoryProtocol {
    var currentUser: User? { get }
    func signIn(email: String, password: String) async throws -> User
    func signUp(email: String, password: String) async throws -> User
    func signOut() throws
}

final class FirebaseAuthRepository: AuthRepositoryProtocol {
    private let auth: Auth

    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    var currentUser: User? {
        auth.currentUser.map(Self.mapUser)
    }

    func signIn(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return Self.mapUser(result.user)
        } catch {
            throw Self.mapError(error)
        }
    }

    func signUp(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return User(id: result.user.uid, email: email)
        } catch {
            throw Self.mapError(error)
        }
    }

    func signOut() throws {
        do { try auth.signOut() } catch { throw AuthError.unknown }
    }

    // MARK: - Mapeos Firebase → dominio

    // `FirebaseAuth.User` es el de Firebase; `User` es el tuyo.
    private static func mapUser(_ fbUser: FirebaseAuth.User) -> User {
        let email = fbUser.email ?? ""
        let fallbackName = email.components(separatedBy: "@").first ?? ""
        return User(id: fbUser.uid,
                    email: email)
    }

    private static func mapError(_ error: Error) -> AuthError {
        guard let code = AuthErrorCode(_bridgedNSError: error as NSError) else {
            return .unknown
        }

        switch code.code {
        case .wrongPassword, .userNotFound, .invalidCredential:
            return .invalidCredentials
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .networkError:
            return .network
        default:
            return .unknown
        }
    }
}
