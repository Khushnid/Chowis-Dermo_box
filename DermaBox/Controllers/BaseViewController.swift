//
//  BaseViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Bekzod Rakhmatov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Toaster
import ChowisSDK
import SystemConfiguration.CaptiveNetwork

class BaseViewController: UIViewController, UITextFieldDelegate {
    
    let frame = CGRect(x: (UIScreen.main.bounds.midX - (30)),
                       y: (UIScreen.main.bounds.midY - (30)),
                       width: 30,
                       height: 30)
    
    lazy var activityIndicator: NVActivityIndicatorView = {
        let activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = .circleStrokeSpin
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    var activityBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    var animatedDistance: CGFloat?
    var keyboardHeight: CGFloat = 0.0
    var textFieldRect: CGRect?
    var keyboardFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityBackground()
        setupInitials()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupInitials() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    private func setupActivityBackground() {
        view.addSubview(self.activityBackgroundView)
        activityBackgroundView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            self.activityBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.activityBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.activityBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.activityBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
}

// MARK:  Swipe back
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK:  Toast message and activity indicator
extension BaseViewController {
    func showToastMessageWith(text: String) {
        if Thread.isMainThread {
            Toast(text: text).show()
        } else {
            DispatchQueue.main.async {
                Toast(text: text).show()
            }
        }
    }
    
    func showActivityIndicator() {
        if Thread.isMainThread {
            self.addActivityIndicator()
        } else {
            DispatchQueue.main.async {
                self.addActivityIndicator()
            }
        }
    }
    
    private func addActivityIndicator() {
        self.activityBackgroundView.bringSubviewToFront(self.view)
        self.activityBackgroundView.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        if Thread.isMainThread {
            self.removeActivityIndicator()
        } else {
            DispatchQueue.main.async {
                self.removeActivityIndicator()
            }
        }
    }
    
    fileprivate func removeActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityBackgroundView.isHidden = true
    }
}


// MARK:  Helpers
extension BaseViewController {
    func getDiagnosisDescription(withValue value: Int, mode: DiagnosisMode) -> String {
        
        var description = "Excellent".localized
        
        var level1 = 0
        var level2 = 0
        var level3 = 0
        var level4 = 0
        
        switch mode {
        case .skinConditions:
            level1 = 26
            level2 = 46
            level3 = 51
            level4 = 76
            
            if value < level1 {
                description = "Moisturized".localized
            } else if value < level2 {
                description = "Normal".localized
            } else if value < level3 {
                description = "Slightly dehydrated".localized
            } else if value < level4 {
                description = "Dehydrated".localized
            } else {
                description = "Very dehydrated".localized
            }
            
        case .pores:
            level1 = 15
            level2 = 21
            level3 = 28
            level4 = 33
            
            if value < level1 {
                description = "Excellent".localized
            } else if value < level2 {
                description = "Slightly dilated".localized
            } else if value < level3 {
                description = "Dilated".localized
            } else {
                description = "Very dilated".localized
            }
            
        case .spots:
            
            level1 = 13
            level2 = 18
            level3 = 27
            level4 = 41
            
            if value < level1 {
                description = "Good".localized
            } else if value < level2 {
                description = "Few".localized
            } else if value < level3 {
                description = "Some".localized
            } else {
                description = "High".localized
            }
            
        case .wrinkles:
            
            level1 = 27
            level2 = 32
            level3 = 39
            level4 = 46
            
            if value < level1 {
                description = "Good".localized
            } else if value < level2 {
                description = "Fine lines".localized
            } else if value < level3 {
                description = "Expression lines".localized
            } else {
                description = "Deep wrinkles".localized
            }
            
        case .impurities:
            
            level1 = 4
            level2 = 8
            level3 = 16
            level4 = 24
            
            if value < level1 {
                description = "Good".localized
            } else if value < level2 {
                description = "Few".localized
            } else if value < level3 {
                description = "Some".localized
            } else {
                description = "High".localized
            }
            
        case .keratin:
            
            level1 = 9
            level2 = 14
            level3 = 20
            level4 = 23
            
            if value < level1 {
                description = "Good".localized
            } else if value < level2 {
                description = "Few".localized
            } else if value < level3 {
                description = "Some".localized
            } else {
                description = "High".localized
            }
            
        default:
            break
        }
        
        return description
    }
    
    func goToWifiSetting() {
        openWifiSettings()
    }
    
    func getSSIDInfo() -> String {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        
        return ssid ?? ""
    }
    
    func isCNDPConnected() -> Bool {
        
        let ssid = self.getSSIDInfo()
        print("SSID: ", ssid)
        
        let mode: CWConnectionMode = CWHandSetBroker.shared().getConnectionMode()
        
        if mode == kCWConnectionMode_AP {
            if let savedSSID = defaults.value(forKey: AP_MODE_SSID) as? String {
                if ssid == savedSSID {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            let rangeCDP = (ssid as NSString).range(of: "cdp")
            let rangeCID = (ssid as NSString).range(of: "CID")
            
            if(rangeCDP.location == NSNotFound || rangeCDP.length == 0) && (rangeCID.location == NSNotFound || rangeCID.length == 0) {
                return false
            }
            
            return true
        }
    }
    
    func isNetworkConnected() -> Bool {
        return MyReachability.isConnectedToNetwork()
    }
}

// MARK:  Hiding Keyboard methods
extension BaseViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.keyboardHeight = keyboardRect.height
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if keyboardFirstTime {
            let shortDelay = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: shortDelay) {
                
                self.textFieldRect = self.view.window?.convert(textField.bounds, from: textField)
                
                let viewRect: CGRect = self.view.window?.convert(self.view.bounds, from: self.view) ?? .zero
                let midline: CGFloat = self.textFieldRect?.origin.y ?? 0.0 + (self.textFieldRect?.size.height ?? 0)
                let numerator: CGFloat = midline - viewRect.origin.y - 0.45 * viewRect.size.height
                let denominator: CGFloat = 0.45 * viewRect.size.height
                var heightFraction: CGFloat = numerator / denominator
                
                if heightFraction < 0.0 {
                    heightFraction = 0.0
                } else if heightFraction > 1.0 {
                    heightFraction = 1.0
                }
                
                self.animatedDistance = floor(self.keyboardHeight * heightFraction)
                
                var viewFrame: CGRect = self.view.frame
                viewFrame.origin.y -= self.animatedDistance ?? 0
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.view.frame = viewFrame
                }, completion: nil)
            }
            
            keyboardFirstTime = false
            
        } else {
            
            self.textFieldRect = self.view.window?.convert(textField.bounds, from: textField)
            
            let viewRect: CGRect = self.view.window?.convert(self.view.bounds, from: self.view) ?? .zero
            let midline: CGFloat = self.textFieldRect?.origin.y ?? 0 + (self.textFieldRect?.size.height ?? 0)
            let numerator: CGFloat = midline - viewRect.origin.y - 0.45 * viewRect.size.height
            let denominator: CGFloat = 0.45 * viewRect.size.height
            var heightFraction: CGFloat = numerator / denominator
            
            if heightFraction < 0.0 {
                heightFraction = 0.0
            } else if heightFraction > 1.0 {
                heightFraction = 1.0
            }
            
            animatedDistance = floor(keyboardHeight * heightFraction)
            
            var viewFrame: CGRect = self.view.frame
            viewFrame.origin.y -= self.animatedDistance ?? 0
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.view.frame = viewFrame
            }, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var viewFrame: CGRect = self.view.frame
        viewFrame.origin.y += self.animatedDistance ?? 0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            self.view.frame = viewFrame
        }, completion: nil)
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
