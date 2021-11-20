//
//  DeviceActivationInputViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol DeviceActivationInputViewControllerDelegate: class {
    
    func didSelectDeviceActivationInputViewControllerSubmitButton()
    func didSelectDeviceActivationInputViewControllerCancelButton()
}

class DeviceActivationInputViewController: BaseViewController, LoadingPopupViewControllerDelegate {
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var enterSerialNumberTextField: UITextField!
    @IBOutlet var enterEmailAddressTextField: UITextField!
    @IBOutlet var enterPasswordTextField: UITextField!
    @IBOutlet var activationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    weak var delegate: DeviceActivationInputViewControllerDelegate?
    var serialNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let serialNumber = self.serialNumber {
            
            self.enterSerialNumberTextField.text = serialNumber
        }
        
        if let companyPassword = defaults.value(forKey: COMPANY_PASSWORD) as? String {
            self.enterPasswordTextField.text = companyPassword
        } else {
            self.enterPasswordTextField.text = "CH7950"
        }
        self.setLocalization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.enterSerialNumberTextField.addPadding(.both(16))
        self.enterEmailAddressTextField.addPadding(.both(16))
        self.enterPasswordTextField.addPadding(.both(16))
        
        self.enterPasswordTextField.layer.borderWidth = 1
        self.enterSerialNumberTextField.layer.borderWidth = 1
        self.enterEmailAddressTextField.layer.borderWidth = 1
        
        self.enterPasswordTextField.layer.borderColor = UIColor.darkGray.cgColor
        self.enterSerialNumberTextField.layer.borderColor = UIColor.darkGray.cgColor
        self.enterEmailAddressTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
        self.submitButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.submitButton.frame.size.height / 2)
        self.enterSerialNumberTextField.layer.cornerRadius = self.enterSerialNumberTextField.frame.size.height / 2
        self.enterPasswordTextField.layer.cornerRadius = self.enterPasswordTextField.frame.size.height / 2
        self.enterEmailAddressTextField.layer.cornerRadius = self.enterEmailAddressTextField.frame.size.height / 2
    }
    
    func setLocalization() {
        self.activationLabel.text = "NOTICE!".localized
        self.titleLabel.text = "Input Device Details".localized
        self.submitButton.setTitle("SUBMIT".localized, for: .normal)
        self.cancelButton.setTitle("Back".localized, for: .normal)
        self.enterSerialNumberTextField.placeholder = "Serial Number".localized
        self.enterEmailAddressTextField.placeholder = "Enter Email".localized
    }
    
    func didSelectLoadingPopupViewControllerDoneLoading(done: Bool) {
        
        if done {
            
            self.dismiss(animated: true) {

                self.delegate?.didSelectDeviceActivationInputViewControllerSubmitButton()
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectDeviceActivationInputViewControllerCancelButton()
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if self.enterSerialNumberTextField.text?.count ?? 0 > 0 && self.enterPasswordTextField.text?.count ?? 0 > 0 {
            
            defaults.setValue(self.enterSerialNumberTextField.text ?? "", forKey: SERIAL_NUMBER)
            defaults.setValue(self.enterEmailAddressTextField.text ?? "", forKey: EMAIL_ADDRESS)
            defaults.setValue(self.enterPasswordTextField.text ?? "", forKey: COMPANY_PASSWORD)
            
            ModalController.shared.presentLoadingPopupViewController(
                presentingViewController: self,
                delegate: self,
                titleText: "NOTICE!".localized,
                messageText: "Verifying, Please wait.".localized,
                buttonText: "CANCEL".localized)
            
        } else {
         
            if self.enterSerialNumberTextField.text?.count ?? 0 < 1 {
                
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "NOTICE!".localized,
                    messageText: "Please enter serial number first!".localized,
                    buttonText: "OK".localized)
                
                return
            }
            
            if self.enterPasswordTextField.text?.count ?? 0 < 1 {
                
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "NOTICE!".localized,
                    messageText: "Please enter phone number first!".localized,
                    buttonText: "OK".localized)
                
                return
            }
        }
    }
}
