//
//  CustomerDetailsVC.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 4/15/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
import UIKit


protocol PhoneNumberInputViewControllerDelegate: AnyObject {
    func didSelectPhoneNumberInputViewControllerSubmitButton()
}

class PhoneNumberInputViewController: BaseViewController, LoadingPopupViewControllerDelegate, UIPickerViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var CCodePicker: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputNumberLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
    lazy var countryCodePickerView: CountryCodePicker! = {
        let pickerView = CountryCodePicker()
        return pickerView
    }()
    
    lazy var countryCodePickerViewToolbar: UIToolbar! = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         UIBarButtonItem(title: "Done".localized, style: .done, target: self, action: #selector(doneButtonPressed(_:)))]
        return toolbar
    }()
    
    //MARK: - Properties
    weak var delegate: PhoneNumberInputViewControllerDelegate?
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CCodePicker.inputView = countryCodePickerView
        CCodePicker.inputAccessoryView = countryCodePickerViewToolbar
        self.phoneTextField.delegate = self
        self.CCodePicker.delegate = self
        self.setLocalization()
    }
    
    func setLocalization() {
        self.titleLabel.text = "Login".localized
        self.inputNumberLabel.text = "Input Customer Telephone Number".localized
        self.phoneTextField.placeholder = "Enter Mobile Number".localized
        self.CCodePicker.placeholder = "C.Code".localized
        self.submitButton.setTitle("OK".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.phoneTextField.addPadding(.both(16))
        self.CCodePicker.addPadding(.both(16))
        self.phoneTextField.layer.borderWidth = 1
        self.CCodePicker.layer.borderWidth = 1
        self.CCodePicker.layer.masksToBounds = true
        self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height / 2
        self.submitButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.submitButton.frame.size.height / 2)
        self.CCodePicker.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.phoneTextField.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.CCodePicker.layer.cornerRadius = 5
        self.phoneTextField.layer.cornerRadius = 5
        let currentLan = defaults.object(forKey: CURRENT_LANGUAGE) as? String ?? "en"
        if currentLan == "he" {
            stackView.removeArrangedSubview(CCodePicker)
            stackView.setNeedsLayout()
            stackView.layoutIfNeeded()
            stackView.insertArrangedSubview(CCodePicker, at: 1)
            stackView.setNeedsLayout()
        } else {
            stackView.removeArrangedSubview(CCodePicker)
            stackView.setNeedsLayout()
            stackView.layoutIfNeeded()
            stackView.insertArrangedSubview(CCodePicker, at: 0)
            stackView.setNeedsLayout()
        }
        
    }
    
    func didSelectLoadingPopupViewControllerDoneLoading(done: Bool) {
        if done {
            self.dismiss(animated: true)
                {  self.delegate?.didSelectPhoneNumberInputViewControllerSubmitButton()  }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if  (self.phoneTextField.text?.count ?? 0 > 0) && (self.CCodePicker.text?.count ?? 0 > 0) {
            let number : String = (self.CCodePicker.text ?? "") + (self.phoneTextField.text ?? "")
            getCustomerInfo(phone: number)
            ModalController.shared.presentLoadingPopupViewController(
                presentingViewController: self,
                delegate: self,
                titleText: "Retrieving data...".localized,
                messageText: "Please wait...".localized,
                buttonText: "CANCEL".localized)
            
        } else {
            if self.phoneTextField.text?.count ?? 0 < 1 {
                
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "NOTICE!".localized,
                    messageText: "Please enter phone number first!".localized,
                    buttonText: "OK".localized)
                
                return
            }
            
            if self.CCodePicker.text?.count ?? 0 < 1 {
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "NOTICE!".localized,
                    messageText: "Please select code country first!".localized,
                    buttonText: "OK".localized)
                return
            }
        }
    }
    
    @IBAction override func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        CCodePicker.text = countryCodePickerView.selectedCountryCode
        CCodePicker.resignFirstResponder()
    }
    
    func getCustomerInfo(phone: String) {
//        defaults.setValue("998901754718", forKey: USER_PHONE_NUMBER)
//        defaults.setValue("AMAL", forKey: USER_FIRST_NAME)
//        defaults.setValue("AKHTAMOV", forKey: USER_LAST_NAME)
//        defaults.setValue("23/09/1998", forKey: USER_BIRTHDAY)
//        defaults.setValue("spectre-98@mail.ru", forKey: USER_EMAIL_ADDRESS)
        ServiceManager.shared.getCustomerInfo(phoneNumber: phone) { (customerInfo, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            if let customerInfo = customerInfo {
                if customerInfo.error == false {
                    DispatchQueue.main.async {
                        defaults.setValue(customerInfo.ID ?? 0, forKey: USER_ID)
                        defaults.setValue(customerInfo.phoneNumber ?? "", forKey: USER_PHONE_NUMBER)
                        defaults.setValue(customerInfo.firstName, forKey: USER_FIRST_NAME)
                        defaults.setValue(customerInfo.lastName, forKey: USER_LAST_NAME)
                        defaults.setValue(customerInfo.birthDate, forKey: USER_BIRTHDAY)
                        defaults.setValue(customerInfo.email, forKey: USER_EMAIL_ADDRESS)
                    }
                } else {
                    
                }
                
            }
        }
    }
}

