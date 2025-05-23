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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .map { [weak self] in self?.validateEmail($0) ?? false }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest($email, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .assign(to: \.isFormValid, on: self)
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

