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
    @IBOutlet weak var cellularButton: UIButton!
    @IBOutlet weak var wifiRouterButton: UIButton!
    weak var delegate: ConnectionTypeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Internet.Connection".localized
        self.deviceParingLabel.text = "Please select the internet connection\n you wish to use:".localized
        self.wifiPointLabel.text = "Wi-Fi Router Internet Connection".localized
        self.celullarPointLabel.text = "Mobile Phone Data Connection".localized
        self.MobileButton.layer.cornerRadius = 7
        self.WifiButton.layer.cornerRadius = 7
        self.cellularButton.applyGradientForView(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 7)
        self.wifiRouterButton.applyGradientForView(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: 7)
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
