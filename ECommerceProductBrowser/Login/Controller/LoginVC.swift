//
//  LoginVC.swift
//  ECommerceProductBrowser
//
//  Created by Arjun Shukla on 23/05/25.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    
    // IB Outlets
    @IBOutlet weak var vWEmail: UIView!
    @IBOutlet weak var vWPassword: UIView!

    @IBOutlet weak var lblErrorEmail: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowHideSecurePasword: UIButton!
    
    // Variables
    fileprivate var showPassword = false
    
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    

    // MARK: View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpUI()
        // Binding Email Txt Field
        self.setupBindings()
    }
    
    private func setupBindings() {
        // Observe UITextField text changes and update ViewModel.email
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: txtFldEmail)
            .compactMap { ($0.object as? UITextField)?.text }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        
        
        viewModel.$email
            .combineLatest(viewModel.$isEmailValid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] email, isValid in
                self?.lblErrorEmail.isHidden = email.isEmpty || isValid
                self?.btnLogin.isEnabled = isValid
            }
            .store(in: &cancellables)
        
        // Update password as user types
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: txtFldPassword)
            .compactMap { ($0.object as? UITextField)?.text }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)

        // React when both fields are filled
        viewModel.$isFormValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFilled in
                // Example: Reload table or enable login button
                self?.btnLogin.isEnabled = isFilled
                
                self?.btnLogin.backgroundColor = isFilled ? ColorUtility.primaryColor : ColorUtility.borderColor
                self?.btnLogin.setTitleColor(isFilled ? ColorUtility.clr_white : ColorUtility.secondaryColor, for: .normal)
            }
            .store(in: &cancellables)
    }
    
    private func setUpUI(){
        
        // Setup Login Button UI
        
        self.txtFldEmail.text = "arjun@gmail.com"
        self.txtFldPassword.text = "1234"
        
        self.btnLogin.layer.cornerRadius = UIConstants.Button.cornerRadius
        
        // Call Textfield Delegate
        self.txtFldEmail.delegate = self
        self.txtFldPassword.delegate = self
        
        // Set Up Corner Radius
        vWEmail.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                          borderWidth: UIConstants.View.borderWidth,
                          borderColor: ColorUtility.borderColor)
        
        vWPassword.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                          borderWidth: UIConstants.View.borderWidth,
                          borderColor: ColorUtility.borderColor)
        
    }
    
    @IBAction func togglePasswordVisibility(_ sender: Any) {
        
        showPassword.toggle()
        txtFldPassword.isSecureTextEntry = !showPassword
        
        let imageName = showPassword ? "eye_Off" : "eye_ON"
        btnShowHideSecurePasword.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func actionLoginTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        
        self.showAlert(title: "Success", message: "Login successful.") {
            print("OK tapped")
            // Navigate to another screen, etc.
        }
        
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginVC : UITextFieldDelegate {
    
    enum EditingState {
        case didBegin
        case didEnd
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateTextfieldView(textField, State: .didBegin)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateTextfieldView(textField, State: .didEnd)
    }
    
    private func updateTextfieldView (_ textField:UITextField ,State :EditingState ){
        
        switch textField {
            
        case txtFldEmail:
            
            // VW Email
            vWEmail.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                              borderWidth: UIConstants.View.borderWidth,
                              borderColor: State == .didBegin ? ColorUtility.primaryColor: ColorUtility.borderColor)
            // VW Password
            vWPassword.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                                 borderWidth: UIConstants.View.borderWidth,
                                 borderColor: ColorUtility.borderColor)
        case txtFldPassword:
            
            // VW Password
            vWPassword.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                                 borderWidth: UIConstants.View.borderWidth,
                                 borderColor: State == .didBegin ? ColorUtility.primaryColor: ColorUtility.borderColor)
            
            
            // VW Password
            vWEmail.setBorder(cornerRadius: UIConstants.View.cornerRadius,
                                 borderWidth: UIConstants.View.borderWidth,
                                 borderColor: ColorUtility.borderColor)
        default:
            break
        }
    }
    
}
