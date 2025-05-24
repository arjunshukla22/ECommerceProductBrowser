//
//  LoginViewModel.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//


import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    @Published private(set) var isEmailValid: Bool = false
    @Published private(set) var isFormValid: Bool = false
    @Published private(set) var isLoading: Bool = false
    
    
    @Published var loginResult: LoginResponse? = nil   // ✅ Real result
    @Published var errorMessage: String? = nil         // ✅ For failure
    
    private let loginService: LoginServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    
    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
        
        $email
            .map { [weak self] in self?.validateEmail($0) ?? false }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($email, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
    
    
    func login() {
        isLoading = true
        errorMessage = nil
        loginResult = nil
        
        loginService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = ErrorMapper.message(for: error)
                }
            } receiveValue: { [weak self] response in
                self?.loginResult = response // ✅ Set result here
            }
            .store(in: &cancellables)
    }
    
    
    
    private func validateEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        guard let regex = regex else { return false }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let matches = regex.numberOfMatches(in: email, options: [], range: range)
        
        return matches > 0
    }
}

