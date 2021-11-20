//
//  APSettingViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/03.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK
import SystemConfiguration.CaptiveNetwork

protocol APSettingViewControllerDelegate {
    
    func didSelectAPSettingViewControllerSuccess()
}

class APSettingViewController: BaseViewController, CWHandSetDelegate, TwoButtonMessagePopupViewControllerDelegate, CWConnectManagerDelegate, LoadingPopupViewControllerDelegate {
    
    func didSelectLoadingPopupViewControllerDoneLoading(done: Bool) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var apInformationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ssidTextField: UITextField!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var securityLabel: UILabel!
    @IBOutlet var wapButton: UIButton!
    @IBOutlet var webButton: UIButton!
    @IBOutlet var wepButton: UIButton!
    @IBOutlet var connectButton: UIButton!
    
    var delegate: APSettingViewControllerDelegate?
    var selectedSecurity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "AP Information".localized
        self.descriptionLabel.text = "Please, enter name, password and select security type of your Wi-Fi router to switch to AP mode.".localized
        self.ssidTextField.placeholder = "Enter Router/Modem SSID".localized
        self.passwordTextField.placeholder = "Enter Password".localized
        self.securityLabel.text = "Security".localized
        self.selectButton.setTitle("Select".localized, for: .normal)
        self.connectButton.setTitle("Connect".localized, for: .normal)
        
        if let ssid = defaults.value(forKey: AP_MODE_SSID) as? String {
            
            self.ssidTextField.text = ssid
        }
        
        if let password = defaults.value(forKey: AP_MODE_PASSWORD) as? String {
            
            self.passwordTextField.text = password
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(cwHandSetDidErrorNotification(notification:)), name: NSNotification.Name(rawValue: CWHandSetDidErrorNotify), object: nil)
        
        let mode: CWConnectionMode = CWHandSetBroker.shared().getConnectionMode()
        print("MODE: \(mode)")
    }
    
    @objc func cwHandSetDidErrorNotification(notification: NSNotification) {
        
        self.hideActivityIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.selectButton.layer.cornerRadius = self.selectButton.frame.size.height / 2
        self.webButton.layer.cornerRadius = self.webButton.frame.size.height / 2
        self.wepButton.layer.cornerRadius = self.wepButton.frame.size.height / 2
        self.wapButton.layer.cornerRadius = self.wapButton.frame.size.height / 2
        self.connectButton.layer.cornerRadius = self.connectButton.frame.size.height / 2
        self.ssidTextField.layer.cornerRadius = self.ssidTextField.frame.size.height / 2
        self.passwordTextField.layer.cornerRadius = self.passwordTextField.frame.size.height / 2
        
        self.ssidTextField.addPadding(.both(16))
        self.passwordTextField.addPadding(.both(16))
        
        self.ssidTextField.layer.borderWidth = 1
        self.passwordTextField.layer.borderWidth = 1
        
        self.ssidTextField.layer.borderColor = UIColor.darkGray.cgColor
        self.passwordTextField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed() {
        
        self.goToWifiSetting()
    }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
    
    @IBAction func passwordSecurityButtonPressed(_ sender: Any) {
        
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    @IBAction func securityButtonPressed(_ sender: UIButton) {
        
        self.wapButton.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.wepButton.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.webButton.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        sender.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0.368627451, blue: 0.5960784314, alpha: 1)
        
        self.selectedSecurity = sender.tag
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        
        guard let ssid = self.ssidTextField.text else {
            
            self.showToastMessageWith(text: "SSID is empty. Please enter your router SSID.")
            return
        }
        
        guard let password = self.passwordTextField.text else {
            
            self.showToastMessageWith(text: "Password is empty. Please enter WiFi password.")
            return
        }
        
        if ssid == "" {
            
            self.showToastMessageWith(text: "SSID is empty. Please enter your router SSID.")
            return
        }
        
        if password == "" {
            
            self.showToastMessageWith(text: "Password is empty. Please enter WiFi password.")
            return
        }
        
        let connectionMode: CWConnectionMode = kCWConnectionMode_AP
        var securityType: CWWiFiSecurityType = kCWWiFiSecurityType_WEB
        
        switch self.selectedSecurity {
        
            case 0:
                securityType = kCWWiFiSecurityType_WEB
                break
            case 1:
                securityType = kCWWiFiSecurityType_WEP
                break
            default:
                securityType = kCWWiFiSecurityType_WPA_WAP2
                break
        }
        
        if(!self.isCNDPConnected()) {
            
            ModalController.shared.presentTwoButtonMessagePopupViewController(
                withTitle: "NOTICE!".localized,
                message: "You are not connected to the device. Please connect to your device to continue analysis".localized,
                leftButtonText: "OK".localized,
                rightButtonText: "CANCEL".localized,
                presentingViewController: self,
                delegate: self)
            
        } else {
            
            if CWConnectManager.shared().isConnected() == false {
                
                CWConnectManager.shared().connect(withVideoStreamStart: true, delegate: self)
                
            } else {
                
                let mode: CWConnectionMode = CWHandSetBroker.shared().getConnectionMode()
                
                if mode == connectionMode {
                    
                    self.dismiss(animated: true) {

                        self.delegate?.didSelectAPSettingViewControllerSuccess()
                    }
                    
                    return
                }
                
                ModalController.shared.presentLoadingPopupViewController(
                    presentingViewController: self,
                    delegate: self,
                    titleText: "DEVICE PAIRING".localized,
                    messageText: "Connecting to the device.\nPlease wait...".localized,
                    buttonText: "OK".localized)
                
                defaults.setValue(ssid, forKey: AP_MODE_SSID)
                defaults.setValue(password, forKey: AP_MODE_PASSWORD)
                defaults.synchronize()
                let result = CWHandSetBroker.shared().switchToAPMode(withSSID: ssid, password: password, securityType: securityType, delegate: self)
                
                if result == false {
                    
                    ModalController.shared.dismissLoadingPopupViewController()
                    ModalController.shared.presentOneButtonMessagePopupViewController(
                        presentingViewController: self,
                        titleText: "NOTICE!".localized,
                        messageText: "Failed to set AP informations!".localized,
                        buttonText: "OK".localized)
                    
                } else {
                    
                    ModalController.shared.dismissLoadingPopupViewController()
                    ModalController.shared.presentOneButtonMessagePopupViewController(
                        presentingViewController: self,
                        titleText: "Connected!".localized,
                        messageText: "Device has been switched to AP mode.".localized,
                        buttonText: "OK".localized,
                        icon: #imageLiteral(resourceName: "check"))
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
