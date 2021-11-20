//
//  SettingsViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/25.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet var settingsTitleLabel: UILabel!
    @IBOutlet var changeLanguageButton: UIButton!
    @IBOutlet var cameraSettingsButton : UIButton!
    @IBOutlet var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.cameraSettingsButton.setTitle("CAMERA SETTINGS".localized, for: .normal)
        self.changeLanguageButton.setTitle("CHANGE LANGUAGE".localized, for: .normal)
        
        self.settingsTitleLabel.text = "SETTINGS".localized
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.cameraSettingsButton.layer.cornerRadius = self.cameraSettingsButton.frame.size.height / 2
        self.changeLanguageButton.layer.cornerRadius = self.changeLanguageButton.frame.size.height / 2
        self.cameraSettingsButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.cameraSettingsButton.frame.size.height / 2)
        self.changeLanguageButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.changeLanguageButton.frame.size.height / 2)
    }
    
    private func appVersion() {
        let appVersion = Bundle.main.releaseVersionNumber ?? "1.0.0"
        self.versionLabel.text = "Version:".localized + " \(appVersion)"
    }
    
    
    @IBAction func changeLanguageButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToLanguageVC", sender: self)
    }
    
    @IBAction func cameraSettingsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToCameraSettingsVC", sender: self)
    }
}
