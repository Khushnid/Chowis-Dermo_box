//
//  CustomerDetailsVC.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 4/15/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol PhoneNumberActivationInputViewControllerDelegate: class {
    
    func didSelectDeviceActivationInputViewControllerSubmitButton()
    func didSelectDeviceActivationInputViewControllerCancelButton()
}

class PhoneNumberInputViewController: BaseViewController, LoadingPopupViewControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var CCodePicker: CountryCodePicker!
    
    //MARK: - Proeprties
    weak var delegate: DeviceActivationInputViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.phoneTextField.addPadding(.both(16))
        self.CCodePicker.layer.borderWidth = 1
        self.phoneTextField.layer.borderWidth = 1
        self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height / 2
        self.submitButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.submitButton.frame.size.height / 2)
        self.CCodePicker.layer.cornerRadius = self.CCodePicker.layer.cornerRadius / 3
        self.phoneTextField.layer.cornerRadius = self.phoneTextField.frame.size.height / 3
    }
    
    func didSelectLoadingPopupViewControllerDoneLoading(done: Bool) {
        
        if done {
            self.dismiss(animated: true)
                {  self.delegate?.didSelectDeviceActivationInputViewControllerSubmitButton()  }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if  self.phoneTextField.text?.count ?? 0 > 0 && self.CCodePicker.selectedCountryCode.count > 0 {
            
            defaults.setValue(self.phoneTextField.text ?? "", forKey: PHONE_NUMBER)
            ModalController.shared.presentLoadingPopupViewController(
                presentingViewController: self,
                delegate: self,
                titleText: "Activation".localized,
                messageText: "Verifying, Please wait.".localized,
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
            
            if self.CCodePicker.selectedCountryCode.count < 1 {
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "NOTICE!".localized,
                    messageText: "Please select code country first!".localized,
                    buttonText: "OK".localized)
                return
            }
        }
    }
}
