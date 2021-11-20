//
//  TestViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 5/22/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import UIKit
import DropDown
import ChowisSDK

class CameraSettingsViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet var cameraSetupButton: UIButton!
    @IBOutlet var WIFIFrequencyButton: UIButton!
    @IBOutlet var cameraSetupView: UIView!
    
    @IBOutlet var WIFIFRequencyView: UIView!
    @IBOutlet var cameraSettingsLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var cameraSetupSettingsView: UIView!
    @IBOutlet var WIFIFrequencyHolderView: UIView!
    @IBOutlet var opticNumberTextField: UITextField!
    @IBOutlet var serialNumberTextField: UITextField!
    
    @IBOutlet var wifiFreqButton: UIButton!
    @IBOutlet var WiFiFreqDropDownBackground: UIView!
    @IBOutlet var WiFiFreqTitle: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    //MARK: - Properties
    let wifiFrequencyDropDown = DropDown()
    let borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    let whiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let selectedBackground = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    
    var wifiModeFreqIndex : Int = 0
    let dataSource = [
        "2G (Default)".localized,
        "5G"
    ]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeBottomBorderToSelectedButtonView()
        self.setupLayouts()
        let wifiFreqIndex = defaults.value(forKey: SEBUM_MODE) as? Int ?? 0
        if wifiFreqIndex < self.dataSource.count {
            
            self.wifiFreqButton.setTitle(self.dataSource[wifiFreqIndex], for: .normal)
        }
        self.setDefaultUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.localizeStrings()
    }
    
    //MARK: - Layouts
    func setupLayouts() {
        
        for button in [self.cameraSetupButton, self.WIFIFrequencyButton] {
            button?.backgroundColor = .clear
            button?.setTitleColor(self.blackColor, for: .normal)
            button?.titleLabel?.numberOfLines = 0
        }
        
        for buttonView in [self.cameraSetupView, self.WIFIFRequencyView] {
            buttonView?.layer.backgroundColor = whiteColor.cgColor
            buttonView?.layer.borderColor = self.borderColor.cgColor
            buttonView?.layer.borderWidth = 1
        }
        
        let borderColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.opticNumberTextField.addPadding(.both(16))
        self.opticNumberTextField.layer.cornerRadius = self.opticNumberTextField.frame.size.height / 2
        self.opticNumberTextField.layer.borderWidth = 1
        self.opticNumberTextField.layer.borderColor = borderColor.cgColor
        
        self.serialNumberTextField.addPadding(.both(16))
        self.serialNumberTextField.layer.cornerRadius = self.serialNumberTextField.frame.size.height / 2
        self.serialNumberTextField.layer.borderWidth = 1
        self.serialNumberTextField.layer.borderColor = borderColor.cgColor
        wifiFrequencyDropDown.dismissMode = .onTap
        wifiFrequencyDropDown.direction = .any
        
        self.wifiFrequencyDropDown.layer.cornerRadius = self.wifiFrequencyDropDown.frame.size.height / 2
        self.wifiFreqButton.layer.borderWidth = 1
        self.wifiFreqButton.layer.borderColor = borderColor.cgColor
        self.wifiFreqButton.layer.cornerRadius = 15
        
        self.saveButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.saveButton.frame.size.height / 2)
        
        self.setupChooseDropDown()
        self.customizeDropDown()
    }
    
    func setupChooseDropDown() {
        
        //SEBUM MODE
        self.wifiFrequencyDropDown.anchorView = self.wifiFreqButton
        self.wifiFrequencyDropDown.bottomOffset = CGPoint(x: 0, y: self.wifiFreqButton.bounds.height)
        self.wifiFrequencyDropDown.dataSource = dataSource
        
        self.wifiFrequencyDropDown.selectionAction = { [weak self] (index, item) in
            self?.wifiModeFreqIndex = index
            defaults.setValue(self?.wifiModeFreqIndex, forKey: WIFI_MODE)
            self?.wifiFreqButton.setTitle(item, for: .normal)
        }
    }
    
    fileprivate func removeBottomBorderToSelectedButtonView(
        selectedButtonView: UIView? = nil,
        selectedButton: UIButton? = nil) {
        
        for button in [self.cameraSetupButton, self.WIFIFrequencyButton] {
            button?.backgroundColor = .clear
            button?.setTitleColor(self.blackColor, for: .normal)
            button?.titleLabel?.numberOfLines = 0
        }
        
        for buttonView in [self.cameraSetupView, self.WIFIFRequencyView] {
            buttonView?.backgroundColor = self.whiteColor
        }
        
        selectedButtonView?.backgroundColor = self.selectedBackground
        selectedButton?.setTitleColor(self.whiteColor, for: .normal)
    }
    
    fileprivate func localizeStrings() {
        opticNumberTextField.placeholder = "OPTIC NUMBER".localized
        serialNumberTextField.placeholder = "SERIAL NUMBER".localized
        cameraSetupButton.setTitle("Camera Setup".localized, for: .normal)
        WIFIFrequencyButton.setTitle("Wi-Fi Frequency".localized, for: .normal)
        cameraSettingsLabel.text = "Camera Settings".localized
        saveButton.setTitle("SAVE".localized, for: .normal)
    }
    
    @IBAction func cameraSetupPressed(_ sender: UIButton) {
        self.removeBottomBorderToSelectedButtonView(
            selectedButtonView: self.cameraSetupView,
            selectedButton: self.cameraSetupButton)
        self.addSubViewToContentView(subview: self.cameraSetupSettingsView, contentHolderView: self.contentView)
    }
    
    @IBAction func WIFIFrequencyPressed(_ sender: UIButton) {
        self.removeBottomBorderToSelectedButtonView(
            selectedButtonView: self.WIFIFRequencyView,
            selectedButton: self.WIFIFrequencyButton)
        self.addSubViewToContentView(subview: self.WIFIFrequencyHolderView, contentHolderView: self.contentView)
    }
    
    func setDefaultUI() {
        self.removeBottomBorderToSelectedButtonView(
            selectedButtonView: self.cameraSetupView,
            selectedButton: self.cameraSetupButton)
        self.addSubViewToContentView(subview: self.cameraSetupSettingsView, contentHolderView: self.contentView)

        if let index = defaults.object(forKey: WIFI_MODE) as? Int {
            self.wifiFreqButton.setTitle(self.dataSource[index], for: .normal)
        }
        
        if let serial = defaults.object(forKey: SERIAL_NUMBER) as? String {
            serialNumberTextField.text = serial
        }
        
        if let optic = defaults.object(forKey: OPTIC_NUMBER) as? String {
            opticNumberTextField.text = optic
        }
    }
    
    func addSubViewToContentView(subview: UIView, contentHolderView: UIView) {
        
        for contentSubview in contentHolderView.subviews {
            contentSubview.removeFromSuperview()
        }
        
        contentHolderView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: contentHolderView.topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: contentHolderView.leftAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: contentHolderView.bottomAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: contentHolderView.rightAnchor).isActive = true
    }
    
    func customizeDropDown() {
        
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = self.wifiFreqButton.frame.size.height
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.cornerRadius = self.wifiFreqButton.frame.size.height / 2
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.5
        appearance.shadowRadius = 10
        appearance.animationduration = 0.1
        appearance.textColor = .darkGray
        appearance.clipsToBounds = true
        
        wifiFrequencyDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
    }
    
    @IBAction func wifiFreqButtonPressed(_ sender: UIButton)
    {  wifiFrequencyDropDown.show()  }
    
    @IBAction func savePressed(_ sender: UIButton) {
        self.donwloadOpticNumberConfigurationFile()
    }
}

extension CameraSettingsViewController {
    private func donwloadOpticNumberConfigurationFile() {
        
        let opticNumber = self.opticNumberTextField.text ?? ""
        if self.isNetworkConnected() {
            self.showActivityIndicator()
            let config = CWHandSetBroker.shared().loadHandSetConfiguration(withOpticNumber: opticNumber, update:false, delegate:self)
            if config == kCWResult_Ok {
                self.cwHandSetDidSuccessSetOpticNumber(opticNumber)
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
}

extension CameraSettingsViewController: CWHandSetDelegate {
    
    func cwHandSetDidSuccessSetOpticNumber(_ opticNumber: String) {
        
        self.hideActivityIndicator()
        UserDefaults.standard.set(opticNumber.uppercased(), forKey: OPTIC_NUMBER)
        self.navigationController?.popViewController(animated: true)
    }
    
    func cwHandSetDidFailSetOpticNumber(_ opticNumber: String, errorCode: CWErrorCode) {
        self.hideActivityIndicator()
        self.showToastMessageWith(text: "The optic number is not valid.".localized)
    }
}

extension CameraSettingsViewController: TwoButtonMessagePopupViewControllerDelegate {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed()
    {  self.goToWifiSetting()  }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
}
