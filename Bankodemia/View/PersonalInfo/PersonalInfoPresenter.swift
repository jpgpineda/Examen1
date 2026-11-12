//
//  PersonalInfoPresenter.swift
//  Bankodemia
//
//  Created by javier pineda on 12/11/26.
//

import Foundation

protocol PersonalView: AnyObject {
    func manageLoader(_ isLoading: Bool)
    func showErrorMessage(_ message: String)
    func showBirthDate(_ text: String)
    func showBirthDateError(_ message: String?)
}

final class PersonalInfoPresenter {
    weak var view: PersonalView?
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let onSavedPersonalInfo: () -> Void
    private var birthDate: Date?
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    init(authRepository: AuthRepositoryProtocol,
         userRepository: UserRepositoryProtocol,
         onSavedPersonalInfo: @escaping () -> Void,
         birthDate: Date? = nil) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.onSavedPersonalInfo = onSavedPersonalInfo
        self.birthDate = birthDate
    }
    
    func didSelectBirthDate(_ date: Date) {
        birthDate = date
        view?.showBirthDate(Self.dateFormatter.string(from: date))
        view?.showBirthDateError(nil)
    }
    
    func didTapSave(name: String, lastName: String, userName: String, phone: String, genre: UserGenre) {
        view?.manageLoader(true)
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let userProfile = UserProfile(id: authRepository.currentUser?.id ?? "",
                                              name: name,
                                              email: authRepository.currentUser?.email ?? "",
                                              lastName: lastName,
                                              userName: userName,
                                              phone: phone,
                                              bornDate: birthDate ?? Date(),
                                              genre: genre)
                try await self.userRepository.save(userProfile)
                self.view?.manageLoader(false)
            } catch {
                self.view?.manageLoader(false)
                self.view?.showErrorMessage(error.localizedDescription)
            }
        }
    }
}

