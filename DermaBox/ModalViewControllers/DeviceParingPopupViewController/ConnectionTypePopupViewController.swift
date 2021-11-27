//
//  DeviceParingPopupViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/01.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol ConnectionTypeDelegate: AnyObject {
    
    func didSelectWififButtuonPopupViewController()
    func didSelectCelullarPopupViewController()
}

class ConnectionTypePopupViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var deviceParingLabel: UILabel!
    @IBOutlet var wifiPointLabel: UILabel!
    @IBOutlet var celullarPointLabel: UILabel!
    @IBOutlet var MobileButton: UIView!
    @IBOutlet var WifiButton: UIView!
    weak var delegate: ConnectionTypeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Internet.Connection".localized
        self.deviceParingLabel.text = "Please select the internet connection\n you wish to use:".localized
        self.wifiPointLabel.text = "Device Wi-Fi Connection".localized
        self.celullarPointLabel.text = "Internet Connection".localized
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.MobileButton.layer.cornerRadius = 5
        self.WifiButton.layer.cornerRadius = 5
        
        self.MobileButton.applyGradientForView(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 5)
        self.WifiButton.applyGradientForView(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 5)
    }
    
    @IBAction func celullarButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            defaults.setValue("celullar_iconGold", forKey: CONNECTION_ICON)
            self.delegate?.didSelectCelullarPopupViewController()
        }
    }
    
    @IBAction func wifiButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            defaults.setValue("wifi_iconGold", forKey: CONNECTION_ICON)
            self.delegate?.didSelectWififButtuonPopupViewController()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
