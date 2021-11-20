//
//  DeviceActivationAgreementViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Bekzod Rakhmatov. All rights reserved.
//

import UIKit

protocol DeviceActivationAgreementViewControllerDelegate: AnyObject {
    
    func didSelectDeviceActivationAgreementViewControllerNextButton()
    func didSelectDeviceActivationAgreementViewControllerCancelButton()
}

class DeviceActivationAgreementViewController: BaseViewController {

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var checkBox: UIButton!
    @IBOutlet var activationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var agreementLabel: UILabel!
    weak var delegate: DeviceActivationAgreementViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkBox.isSelected = false
        self.nextButton.isEnabled = false
        self.setLocalization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    }
    
    @IBAction func checkBoxChecked(_ sender: Any) {
        
        self.checkBox.isSelected = !self.checkBox.isSelected
        self.nextButton.isEnabled = self.checkBox.isSelected
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectDeviceActivationAgreementViewControllerCancelButton()
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectDeviceActivationAgreementViewControllerNextButton()
        }
    }
    
    func setLocalization() {
        activationLabel.text = "NOTICE!".localized
        titleLabel.text = "Initial Device Activation".localized
        bodyLabel.text = "This feature provides additional guarantee that the device and program are synchronized and would provide accurate analysis results. The need for patients\' details are used only for the purposes of conducting a digital skin analysis and for sharing the skin analysis results with the patient.".localized
        agreementLabel.text = "I Agree and Understand".localized
        nextButton.setTitle("Yes".localized, for: .normal)
        cancelButton.setTitle("Not now".localized, for: .normal)
    }
}
