//
//  MainViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/19.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import CoreLocation
import ChowisSDK
import Reachability
import CWSLoginCRM

class MainViewController: BaseViewController {
    
    @IBOutlet var analysisButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var temperatureView: UIView!
    @IBOutlet var otherViews: UIView!
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var minimumTemperatureLabel: UILabel!
    @IBOutlet var maximumTemperatureLabel: UILabel!
    @IBOutlet var temperatureDescriptionLabel: UILabel!
    @IBOutlet var currentLocationLabel: UILabel!
    @IBOutlet var currentUVLabel: UILabel!
    @IBOutlet var currentHumidityLabel: UILabel!
    @IBOutlet var humidityChangePercentageLabel: UILabel!
    @IBOutlet var uvChangedLabel: UILabel!
    @IBOutlet var uvDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet var addDeviceButton: UIButton!
    
    var connectionIcon = ""
    var opticNumber = ""
    var locationManager = CLLocationManager()
    var reachability = try? Reachability()
    var serialNumber: String?
    let crmTokenManager = CRMTokenManager.init()
    var tokenTimer: Timer?
    var isAnalysisButtonPressed: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crmTokenManager.setDelegate(delegate: self)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.currentTemperatureLabel.text = "--°C"
        self.minimumTemperatureLabel.text = "--°C"
        self.maximumTemperatureLabel.text = "--°C"
        self.temperatureDescriptionLabel.text = "--"
        self.currentLocationLabel.text = "--"
        self.currentUVLabel.text = "--"
        self.currentHumidityLabel.text = "--%"
        self.humidityChangePercentageLabel.text = "(--%↑)"
        self.updateWeaterInformationUI()
        self.appVersion()
    }
    
    private func appVersion() {
        let appVersion = Bundle.main.releaseVersionNumber ?? "1.0.0"
        self.versionLabel.text = "Version:".localized + " \(appVersion)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    @objc func updateToken() {
        
        if self.tokenTimer == nil {
         
            self.tokenTimer = Timer.scheduledTimer(timeInterval: 250,
                                     target: self,
                                     selector: #selector(updateToken),
                                     userInfo: nil,
                                     repeats: true)
        }
        
        self.crmTokenManager.requestToken(id: "54bfgdhm5u58luqn", password: "rxc4ai4s2reqg4s5", appID: 44)
    }
    
    fileprivate func localizeStrings() {
        self.analysisButton.setTitle("ANALYSIS".localized, for: .normal)
        self.settingsButton.setTitle("SETTINGS".localized, for: .normal)
        
        self.temperatureLabel.text = "Temperature".localized
        self.humidityLabel.text = "Humidity".localized
        self.locationLabel.text = "Location".localized
        
        self.reachability?.whenReachable = { reachability in
            
            if self.reachability?.connection == .wifi || self.reachability?.connection == .cellular {
                switch reachability.connection {
                case .wifi:
                    self.addDeviceButton.setImage(#imageLiteral(resourceName: "wifi_iconGold"), for: .normal)
                case .cellular:
                    self.addDeviceButton.setImage(#imageLiteral(resourceName: "celullar_iconGold"), for: .normal)
                default:
                    self.addDeviceButton.setImage(nil, for: .normal)
                }
                self.updateToken()
                self.updateWeaterInformationUI()
            }
        }

        do {
            
            try self.reachability?.startNotifier()
        
        } catch {
            
            print("Unable to start notifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connectionIcon = defaults.value(forKey: CONNECTION_ICON) as? String ?? ""
        self.addDeviceButton.setImage(UIImage(named: connectionIcon), for: .normal)
        self.setupObservers()
        self.localizeStrings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.callCheckConnect()
    }
    
    private func callCheckConnect() {

        if (defaults.value(forKey: SERIAL_NUMBER) == nil && defaults.value(forKey: EMAIL_ADDRESS) == nil) {
            ModalController.shared.presentDeviceActivationAgreementViewController(with: self, delegate: self)
        } else if defaults.value(forKey: USER_PHONE_NUMBER) == nil {
            ModalController.shared.presentPhoneNumberInputViewController(
                presentingViewController: self,
                delegate: self)
        } else {
            self.connectToDevice()
        }
    }
    
    func hideActivityIndicatorAndShowToast(message: String) {
        self.hideActivityIndicator()
        self.showToastMessageWith(text: message)
    }
    
    func getTemperatureStatus(_ temp: Int?) -> String {
        
        guard let temp = temp else {
            
            return "Warm".localized
        }
        
        if (temp < 0) {
            return "Very Cold".localized
        } else if (temp > 0 && temp < 11) {
            return "Cold".localized
        } else if (temp > 10 && temp < 20) {
            return "Cool".localized
        } else if (temp > 19 && temp < 25) {
            return "Warm".localized
        } else if (temp > 24 && temp < 29) {
            return "Hot".localized
        } else if (temp > 28 && temp < 33) {
            return "Feeling Hot".localized
        } else if (temp > 32 && temp < 45) {
            return "Very Hot".localized
        } else {
            return "Extremely Hot".localized
        }
    }
    
    fileprivate func updateWeaterInformationUI() {
        
        self.getUserLocationCity()
        
        if reachability?.connection == .cellular || reachability?.connection == .wifi {
         
            guard let location = self.locationManager.location else { return }
            
            ServiceManager.shared.getOneCallWeatherInfoWith(location: location) { (oneCallWeatherModel, error) in
                
                if let error = error {
                    
                    print("ERROR: \(error)")
                    return
                }
                
                if let oneCallWeatherModel = oneCallWeatherModel {
                    
                    if let current = oneCallWeatherModel.current {
                        
                        Util.shared.temperature = current.temp
                        Util.shared.humidity = current.humidity
                        Util.shared.uvIndex = current.uvi
                         
                        DispatchQueue.main.async {
                            
                            self.currentTemperatureLabel.text = "\(Int(current.temp))°C"
                            self.currentUVLabel.text = "\(Int(current.uvi))"
                            self.currentHumidityLabel.text = "\(Int(current.humidity))%"
                            self.humidityChangePercentageLabel.text = "\(oneCallWeatherModel.diffHumidity)"
                            self.uvChangedLabel.text = "\(oneCallWeatherModel.diffUV)"
                            self.temperatureDescriptionLabel.text = self.getTemperatureStatus(Int(current.temp))
                            
                            guard current.uvi <= 5 else {
                                self.uvDescriptionLabel.text = "SPF50~,\nPA+++"
                                return
                            }
                            self.uvDescriptionLabel.text = "SPF30~,\nP+++"
                        }
                    }
                    
                    if let dailys = oneCallWeatherModel.daily {
                        
                        if let daily = dailys.first {
                            
                            if let temp = daily.temp {
                                
                                DispatchQueue.main.async {
                                    
                                    self.maximumTemperatureLabel.text = "\(Int(temp.tempMax))°C"
                                    self.minimumTemperatureLabel.text = "\(Int(temp.tempMin))°C"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        
    fileprivate func getUserLocationCity() {
        
        guard let location = self.locationManager.location else { return }
        
        Util.shared.latitude = "\(location.coordinate.latitude)"
        Util.shared.longitude = "\(location.coordinate.longitude)"
            
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in

            if let locality = placemarks?.first?.locality {

                self.currentLocationLabel.text = locality
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.analysisButton.layer.cornerRadius = 7
        self.settingsButton.layer.cornerRadius = 7
        
        self.temperatureView.layer.cornerRadius = 20
        self.otherViews.layer.cornerRadius = 20
        
        self.temperatureView.layer.borderWidth = 1
        self.otherViews.layer.borderWidth = 1
        
        let borderColor: UIColor = #colorLiteral(red: 0.7490196078, green: 0.5960784314, blue: 0.2156862745, alpha: 0.8470588235)
        
        self.temperatureView.layer.borderColor = borderColor.cgColor
        self.otherViews.layer.borderColor = borderColor.cgColor
        self.analysisButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 5)
        self.settingsButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 5)
    }
    
    private func connectToDevice() {
                
        DiagnosisInformation.shared.resetAll()
        let optic  = UserDefaults.standard.object(forKey: OPTIC_NUMBER) as? String
        if(optic != nil && 0 < optic?.count ?? 0) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
                if(self.isCNDPConnected()) {
                    
                    let config = CWHandSetBroker.shared().loadHandSetConfiguration(withOpticNumber: optic?.uppercased() ?? "", update:false, delegate:self)
                    
                    if config == kCWResult_Ok {
                        
                        if(CWConnectManager.shared().isConnected() == false) {

                            CWConnectManager.shared().connect(withVideoStreamStart: true, delegate: self)
                        } else {
                            
                            if self.isAnalysisButtonPressed == true {
                                self.isAnalysisButtonPressed = false
                                ModalController.shared.presentGenderChoosingViewController(presentingViewController: self, delegate: self)
                            }
                        }
                    }
                } else {
                    
                    if defaults.value(forKey: DID_CHANGE_DEVICE_MODE) as? Bool ?? false == true && defaults.value(forKey: AP_MODE_SSID) as? String ?? "" != "" {
                       
                        let _ = CWHandSetBroker.shared().switchtoDeviceMode()
                        
                        defaults.setValue(false, forKey: DID_CHANGE_DEVICE_MODE)
                        defaults.setValue("", forKey: AP_MODE_SSID)
                        defaults.synchronize()
                        
                        ModalController.shared.presentOneButtonMessagePopupViewController(
                            presentingViewController: self,
                            titleText: "Notice!".localized,
                            messageText: "You have switched from AP mode back to device mode. To complete this step a hard reset is needed. Please press and hold the Capture button of the device for 10 seconds until red LED starts to blink and the device reboots. Wait for the device to be in ready state. Then press OK.".localized,
                            buttonText: "OK".localized)
                    } else {
                        ModalController.shared.presentTwoButtonMessagePopupViewController(
                            withTitle: "NOTICE!".localized,
                            message: "You are not connected to the device. Please connect to your device to continue analysis".localized,
                            leftButtonText: "Connect".localized,
                            rightButtonText: "Cancel".localized,
                            presentingViewController: self,
                            delegate: self)
                    }
                }
            }
            
        } else {
            
            ModalController.shared.presentDeviceInitViewController(presentingViewController: self)
        }
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        defaults.removeObject(forKey: USER_PHONE_NUMBER)
        defaults.removeObject(forKey: USER_FIRST_NAME)
        defaults.removeObject(forKey: USER_LAST_NAME)
        defaults.removeObject(forKey: USER_BIRTHDAY)
        defaults.removeObject(forKey: USER_EMAIL_ADDRESS)
        defaults.removeObject(forKey: USER_ID)
        exit(0)
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToCustomerRegisterationVC", sender: self)
    }
    
    @IBAction func apButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func addDeviceButtonPressed(_ sender: Any) {
        
        ModalController.shared.presentDeviceParingPopupViewController(presentingViewController: self, delegate: self)
    }
    
    @IBAction func analysisButtonPressed(_ sender: Any) {
        
//        self.performSegue(withIdentifier: "TEST", sender: self)
//        return
        self.isAnalysisButtonPressed = true
        self.callCheckConnect()
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToSettingsVC", sender: self)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}

extension MainViewController: CRMTokenDelegate {
    
    func didReceiveToken(token: String) {
        
        Util.shared.token = token
    }
    
    func didFailure(response: [String : Any]) {
        
    }
    
    func didError(errorMessage: String) {
        
    }
}

extension MainViewController: DeviceActivationQRScanViewControllerDelegate {
    
    func didSelectQRCodeDetectedWithSerialNumber(serialNumber: String) {
        
        self.serialNumber = serialNumber
        ModalController.shared.presentDeviceActivationInputViewController(
            with: self.serialNumber,
            presentingViewController: self,
            delegate: self)
    }
    
    func didSelectDeviceActivationQRScanViewControllerManualInputButtonPressed() {
        
        self.serialNumber = nil
        ModalController.shared.presentDeviceActivationInputViewController(
            with: self.serialNumber,
            presentingViewController: self,
            delegate: self)
    }
    
    func didSelectDeviceActivationQRScanViewControllerCancelButtonPressed() {
        
    }
}

extension MainViewController: DeviceActivationInputViewControllerDelegate {
    
    func didSelectDeviceActivationInputViewControllerSubmitButton() {
        ModalController.shared.presentPhoneNumberInputViewController(
            presentingViewController: self,
            delegate: self)
    }
//        ModalController.shared.presentOneButtonMessagePopupViewController(
//            presentingViewController: self,
//            titleText: "ACTIVATION".localized,
//            messageText: "Activation Successful!".localized,
//            buttonText: "Proceed".localized, icon: #imageLiteral(resourceName: "skinToneCheckBoxChecked"))

    
    func didSelectDeviceActivationInputViewControllerCancelButton() {
        
    }
}

extension MainViewController: PhoneNumberInputViewControllerDelegate {
    func didSelectPhoneNumberInputViewControllerSubmitButton() {
        ModalController.shared.presentCustomerInfoViewController(
            presentingViewController: self,
            delegate: self)
    }
}

extension MainViewController: CustomerInfoViewControllerDelegate {
    func didSelectCustomerInfoViewControllerSubmitButton() {
        ModalController.shared.presentConnectionTypeViewController(
            presentingViewController: self,
            delegate: self)
    }
}

extension MainViewController: GenderViewControllerDelegate {
    func didSelectGenderViewControllerNextButton() {
        self.dismiss(animated: true) {
            ModalController.shared.presentEthnicityViewController(
                presentingViewController: self,
                delegate: self)
        }
    }
    
    func didSelectGenderViewControllerCancelButton() {
        
    }
}

extension MainViewController: DeviceActivationAgreementViewControllerDelegate {
    
    func didSelectDeviceActivationAgreementViewControllerNextButton() {
        
        ModalController.shared.presentDeviceActivationQRScanViewController(
            with: self,
            delegate: self)
    }
    
    func didSelectDeviceActivationAgreementViewControllerCancelButton() {
        
    }
}

extension MainViewController: ConnectionTypeDelegate {

    func didSelectCelullarPopupViewController() {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
    }
    
    func didSelectWififButtuonPopupViewController() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl)
        {  UIApplication.shared.open(settingsUrl, completionHandler: nil)  }
    }
}

extension MainViewController: ConnectDirectionVCDelegate {
    
    func didSelectConnectDirectionVCConnectButton(isApMode: Bool) {
        
        if isApMode {
            
            ModalController.shared.presentAPSettingViewController(
                presentingViewController: self,
                delegate: self)
            
        } else {
            
            defaults.setValue(true, forKey: DID_CHANGE_DEVICE_MODE)
            defaults.synchronize()
            
            let mode: CWConnectionMode = CWHandSetBroker.shared().getConnectionMode()
       
            if mode == kCWConnectionMode_AP {
                
                let _ = CWHandSetBroker.shared().switchtoDeviceMode()
                
                self.dismiss(animated: true, completion: nil)
                self.goToWifiSetting()
            } else {
                self.dismiss(animated: true, completion: nil)
                self.goToWifiSetting()
            }
        }
    }
}

extension MainViewController: APSettingViewControllerDelegate {
    
    func didSelectAPSettingViewControllerSuccess() {
        
        ModalController.shared.presentOneButtonMessagePopupViewController(
            presentingViewController: self,
            titleText: "with Access Point (router)".localized,
            messageText: "Connection Successful\n\n\nAccess point has been successfully configured.".localized,
            buttonText: "Home".localized,
            icon: #imageLiteral(resourceName: "check"))
    }
}

extension MainViewController: SkinToneQuestionnaireViewControllerDelegate {
    
    func didSelectSkinToneQuestionnaireViewControllerYesButtonPressed() {
        
    }
    
    func didSelectSkinToneQuestionnaireViewControllerNoButtonPressed() {
        
    }
}

extension MainViewController: TwoButtonMessagePopupViewControllerDelegate {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        self.goToWifiSetting()
    }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
}

extension MainViewController: CWConnectManagerDelegate {
    
    func cwConnectManagerDidSuccessConnectHandSet() {
        
        self.hideActivityIndicatorAndShowToast(message: "Succeed to connect".localized)
        
        let mode: CWConnectionMode = CWHandSetBroker.shared().getConnectionMode()
   
        if mode == kCWConnectionMode_AP {
        
            if defaults.value(forKey: DID_CHANGE_DEVICE_MODE) as? Bool ?? false == true {
                
                let _ = CWHandSetBroker.shared().switchtoDeviceMode()
                
                defaults.setValue(false, forKey: DID_CHANGE_DEVICE_MODE)
                defaults.setValue("", forKey: AP_MODE_SSID)
                defaults.synchronize()
                
                ModalController.shared.presentOneButtonMessagePopupViewController(
                    presentingViewController: self,
                    titleText: "Notice!",
                    messageText: "You have switched from AP mode back to device mode. To complete this step a hard reset is needed. Please press and hold the Capture button of the device for 10 seconds until red LED starts to blink and the device reboots. Wait for the device to be in ready state. Then press OK.",
                    buttonText: "OK")
                
            } else {
                if self.isAnalysisButtonPressed == true {
                    self.isAnalysisButtonPressed = false
                    ModalController.shared.presentGenderChoosingViewController(presentingViewController: self, delegate: self)
                }
            }
        } else {
            
            if defaults.value(forKey: DID_CHANGE_DEVICE_MODE) as? Bool ?? false == true {
                
                let result = CWHandSetBroker.shared().switchtoDeviceMode()
                
                if result {
                    defaults.setValue(false, forKey: DID_CHANGE_DEVICE_MODE)
                    defaults.synchronize()
                }
                
                self.dismiss(animated: true, completion: nil)
                self.goToWifiSetting()
            } else {
                if self.isAnalysisButtonPressed == true {
                    self.isAnalysisButtonPressed = false
                    ModalController.shared.presentGenderChoosingViewController(presentingViewController: self, delegate: self)
                }
            }
        }
    }
    
    func cwConnectManagerDidFailConnectHandSet() {
        
        self.hideActivityIndicatorAndShowToast(message: "Failed to connect hand-set")
    }
}

extension MainViewController: CWHandSetDelegate {
    
    func cwHandSetDidSuccessSetOpticNumber(_ opticNumber: String) {
        
        UserDefaults.standard.set(opticNumber.uppercased(), forKey: OPTIC_NUMBER)
    }
    
    func cwHandSetDidFailSetOpticNumber(_ opticNumber: String, errorCode: CWErrorCode) {
        
        self.hideActivityIndicatorAndShowToast(message: "Failed to setup hand-set")
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        updateWeaterInformationUI()
    }
}

extension MainViewController: SkinColorGroupViewControllerDelegate {
    
    func didSelectSkinColorGroupViewControllerSkinColorGroupButton(with cwSkinScalpColorType: CWSkinScalpColorType) {
        
        if cwSkinScalpColorType != kCWSkinScalpColorType_None {
            
            DiagnosisInformation.shared.customerSkinScalColorType = cwSkinScalpColorType
            self.performSegue(withIdentifier: "GoToDiagnosisVC", sender: self)
        }
    }
}

extension MainViewController: EthnicityViewControllerDelegate {
    
    func didSelectEthnicityViewControllerEthnnicityButton(with cwEthnicity: CWEthnicity) {
        
        if cwEthnicity != kCWEthnicity_None {
            
            DiagnosisInformation.shared.customerEthnicity = cwEthnicity
            ModalController.shared.presentSkinColorGroupViewController(presentingViewController: self, delegate: self)
        }
    }
}

extension MainViewController {
    
    func setupObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidConectedNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidConectedNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidDisconnectedNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidDisconnectedNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidErrorNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidErrorNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidEofNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidEofNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidReceiveBatterySoCNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidReceiveBatterySoCNotify),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwVideoPlayerDidStartDecoding(_:)),
            name: NSNotification.Name(rawValue: CWVideoPlayerDidStartDecoding),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidPressCameraButtonNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidPressCameraButtonNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidPressModeButtonNotification(_:)),
            name: NSNotification.Name(rawValue: CWHandSetDidPressModeButtonNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self, selector:#selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }

    @objc func appMovedToForeground() {
        self.connectToDevice()
    }
    
    @objc func cwVideoPlayerDidStartDecoding(_ notification: Notification?) {
        print("cwVideoPlayerDidStartDecoding")
    }
    
    func cwVideoPlayerDidStartFailed(_ videoPlayer: CWVideoPlayer) {
        print("cwVideoPlayerDidStartFailed")
    }
    
    @objc func cwHandSetDidPressCameraButtonNotification(_ notification: Notification?) {
        print("cwHandSetDidPressCameraButtonNotification")
    }
    
    @objc func cwHandSetDidConectedNotification(_ notification: Notification?) {
        print("cwHandSetDidConectedNotification")
    }
    
    @objc func cwHandSetDidDisconnectedNotification(_ notification: Notification?) {
        print("cwHandSetDidDisconnectedNotification")
    }
    
    @objc func cwHandSetDidErrorNotification(_ notification: Notification?) {
        print("cwHandSetDidErrorNotification")
    }
    
    @objc func cwHandSetDidEofNotification(_ notification: Notification?) {
        print("cwHandSetDidEofNotification")
    }
    
    @objc func cwHandSetDidPressModeButtonNotification(_ notification: Notification?) {
        print("cwHandSetDidPressModeButtonNotification")
    }
    
    @objc func cwHandSetDidReceiveBatterySoCNotification(_ notification: Notification?) {
        print("cwHandSetDidReceiveBatterySoCNotification")
    }
}
