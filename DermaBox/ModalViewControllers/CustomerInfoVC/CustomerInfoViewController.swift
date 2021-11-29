//
//  CustomerInfoViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 4/18/21.j
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol CustomerInfoViewControllerDelegate: AnyObject {
    func didSelectCustomerInfoViewControllerSubmitButton()
}

class CustomerInfoViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthDateTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var birthdayHeader: UILabel!
    @IBOutlet weak var phoneHeader: UILabel!
    @IBOutlet weak var genderHeader: UILabel!
    //MARK: - Properties
    weak var delegate: CustomerInfoViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUserInfo()
        setLocalization()
        setupLanguageDifferences()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.phoneTextField.addPadding(.both(16))
        self.nameTextField.addPadding(.both(16))
        self.birthDateTextField.addPadding(.both(16))
        self.emailTextField.addPadding(.both(16))
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height / 2
        self.submitButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.submitButton.frame.size.height / 2)
        
        self.phoneTextField.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.nameTextField.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.birthDateTextField.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.emailTextField.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        self.emailTextField.layer.cornerRadius = 5
        self.birthDateTextField.layer.cornerRadius = 5
        self.nameTextField.layer.cornerRadius = 5
        self.phoneTextField.layer.cornerRadius = 5
        
        self.emailTextField.isEnabled = true
        self.birthDateTextField.isEnabled = true
        self.nameTextField.isEnabled = true
        self.phoneTextField.isEnabled = true
    }
    
    private func fillUserInfo() {
        self.nameTextField.text = "\(defaults.value(forKey: USER_FIRST_NAME) as? String ?? "") \(defaults.value(forKey: USER_LAST_NAME) as? String ?? "")"
        self.emailTextField.text = defaults.value(forKey: USER_EMAIL_ADDRESS) as? String ?? ""
        self.birthDateTextField.text = defaults.value(forKey: USER_BIRTHDAY) as? String ?? "".localized
        self.phoneTextField.text = defaults.value(forKey: USER_PHONE_NUMBER) as? String ?? "".localized
    }
    
    func setLocalization() {
        self.titleLabel.text = "Customer Details".localized
        submitButton.setTitle("OK".localized, for: .normal)
        
        nameHeader.text = "Customer.Details.Name".localized
        birthdayHeader.text = "Customer.Details.Birthday".localized
        phoneHeader.text = "Customer.Details.Phone".localized
        genderHeader.text = "Customer.Details.Gender".localized
    }
    
    @IBAction func submitPressed(_ sender: UIButton ) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectCustomerInfoViewControllerSubmitButton()
        }
    }
    
    private func setupLanguageDifferences() {
        if checkForEnglish() {
            phoneTextField.textAlignment = .left
            nameTextField.textAlignment = .left
            birthDateTextField.textAlignment = .left
            emailTextField.textAlignment = .left
        } else {
            nameHeader.textAlignment = .right
            birthdayHeader.textAlignment = .right
            phoneHeader.textAlignment = .right
            genderHeader.textAlignment = .right
        }
    }
}
