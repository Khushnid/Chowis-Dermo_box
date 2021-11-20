//
//  DeviceInitViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/06.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK

class DeviceInitViewController: BaseViewController {

    @IBOutlet var deviceInitTitleLabel: UILabel!
    @IBOutlet var opticNumberTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self, selector:#selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        self.opticNumberTextField.autocapitalizationType = .allCharacters
        self.opticNumberTextField.delegate = self
        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.opticNumberTextField.placeholder = "Enter Optic Number".localized
        self.deviceInitTitleLabel.text = "Device Initialization".localized
        self.submitButton.setTitle("SUBMIT".localized, for: .normal)
        self.cancelButton.setTitle("CANCEL".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
        
        let borderColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.opticNumberTextField.addPadding(.both(16))
        self.submitButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.submitButton.frame.size.height / 2)
        self.opticNumberTextField.layer.cornerRadius = self.opticNumberTextField.frame.size.height / 2
        self.opticNumberTextField.layer.borderWidth = 1
        self.opticNumberTextField.layer.borderColor = borderColor.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func donwloadOpticNumberConfigurationFile() {
        
        let opticNumber = self.opticNumberTextField.text ?? ""
        if self.isNetworkConnected() {
            self.showActivityIndicator()
            let config = CWHandSetBroker.shared().loadHandSetConfiguration(withOpticNumber: opticNumber, update:false, delegate:self)
            if config == kCWResult_Ok {
                self.hideActivityIndicator()
                self.dismiss(animated: true)
            }
        } else {
            ModalController.shared.presentTwoButtonMessagePopupViewController(
                withTitle: "NOTICE!".localized,
                message: "It seems like you are not connected to the internet!\nPlease go to the Setting and connect to the Internet.".localized,
                leftButtonText: "OK".localized,
                rightButtonText: "Cancel".localized,
                presentingViewController: self,
                delegate: self)
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        self.donwloadOpticNumberConfigurationFile()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension DeviceInitViewController: CWHandSetDelegate {
    
    func cwHandSetDidSuccessSetOpticNumber(_ opticNumber: String) {
        
        self.hideActivityIndicator()
        self.dismiss(animated: true) {
            
            UserDefaults.standard.set(opticNumber.uppercased(), forKey: OPTIC_NUMBER)
            self.showToastMessageWith(text: "Success to donwload optic number configuration file.")
        }
    }
    
    func cwHandSetDidFailSetOpticNumber(_ opticNumber: String, errorCode: CWErrorCode) {
        self.hideActivityIndicator()
        self.showToastMessageWith(text: "Failed to donwload optic number configuration file.")
    }
}

extension DeviceInitViewController: TwoButtonMessagePopupViewControllerDelegate {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed() {
        
        self.goToWifiSetting()
    }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
}

extension DeviceInitViewController {

    @objc func appMovedToForeground() {
        self.donwloadOpticNumberConfigurationFile()
    }
}
