//
//  EthnicityViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/25.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK

protocol EthnicityViewControllerDelegate: AnyObject {
    func didSelectEthnicityViewControllerEthnnicityButton(with cwEthnicity: CWEthnicity)
}

class EthnicityViewController: BaseViewController {
    
    @IBOutlet var ethnicityTitleLabel: UILabel!
    @IBOutlet var caucasianButton: UIButton!
    @IBOutlet var asianEastButton: UIButton!
    @IBOutlet var darkSkinButton: UIButton!
    @IBOutlet var hispanicButton: UIButton!
    @IBOutlet weak var middleEastNorthAfricaButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var southestAsian: UIButton!
    @IBOutlet weak var southAsian: UIButton!
    
    weak var delegate: EthnicityViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.ethnicityTitleLabel.text = "ETHNICITY".localized
        self.caucasianButton.setTitle("CAUCASIAN".localized, for: .normal)
        self.asianEastButton.setTitle("ASIAN EAST".localized, for: .normal)
        self.darkSkinButton.setTitle("DARK SKINS".localized, for: .normal)
        self.hispanicButton.setTitle("HISPANIC".localized, for: .normal)
        self.middleEastNorthAfricaButton.setTitle("Middle East & North Africa".localized, for: .normal)
        self.southestAsian.setTitle("Southeast Asian".localized, for: .normal)
        self.southAsian.setTitle("South Asian".localized, for: .normal)
        self.cancelButton.setTitle("CANCEL".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupEthnicityButton(button: caucasianButton)
        setupEthnicityButton(button: asianEastButton)
        setupEthnicityButton(button: darkSkinButton)
        setupEthnicityButton(button: hispanicButton)
        setupEthnicityButton(button: middleEastNorthAfricaButton)
        setupEthnicityButton(button: southestAsian)
        setupEthnicityButton(button: southAsian)
        setupEthnicityButton(button: cancelButton)
    }
    
    @IBAction func ethnicityButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectEthnicityViewControllerEthnnicityButton(with: CWEthnicity(rawValue: CWEthnicity.RawValue(sender.tag)))
        }
    }
    
    private func setupEthnicityButton(button: UIButton) {
        button.layer.cornerRadius = self.caucasianButton.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1).cgColor
        button.layer.cornerRadius = self.caucasianButton.frame.size.height / 2
    }
}
