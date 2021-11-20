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
    @IBOutlet var southEastAsianButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
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
        self.southEastAsianButton.setTitle("S/E ASIAN".localized, for: .normal)
        self.cancelButton.setTitle("CANCEL".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let borderColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        self.caucasianButton.layer.cornerRadius = self.caucasianButton.frame.size.height / 2
        self.caucasianButton.layer.borderWidth = 1
        self.caucasianButton.layer.borderColor = borderColor.cgColor
        self.caucasianButton.layer.cornerRadius = self.caucasianButton.frame.size.height / 2

        self.asianEastButton.layer.cornerRadius = self.asianEastButton.frame.size.height / 2
        self.asianEastButton.layer.borderWidth = 1
        self.asianEastButton.layer.borderColor = borderColor.cgColor
        self.asianEastButton.layer.cornerRadius = self.asianEastButton.frame.size.height / 2

        self.darkSkinButton.layer.cornerRadius = self.darkSkinButton.frame.size.height / 2
        self.darkSkinButton.layer.borderWidth = 1
        self.darkSkinButton.layer.borderColor = borderColor.cgColor
        self.darkSkinButton.layer.cornerRadius = self.darkSkinButton.frame.size.height / 2

        self.hispanicButton.layer.cornerRadius = self.hispanicButton.frame.size.height / 2
        self.hispanicButton.layer.borderWidth = 1
        self.hispanicButton.layer.borderColor = borderColor.cgColor
        self.hispanicButton.layer.cornerRadius = self.hispanicButton.frame.size.height / 2

        self.southEastAsianButton.layer.cornerRadius = self.southEastAsianButton.frame.size.height / 2
        self.southEastAsianButton.layer.borderWidth = 1
        self.southEastAsianButton.layer.borderColor = borderColor.cgColor
        self.southEastAsianButton.layer.cornerRadius = self.southEastAsianButton.frame.size.height / 2

        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = borderColor.cgColor
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
    }
    
    @IBAction func ethnicityButtonPressed(_ sender: UIButton) {
                
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectEthnicityViewControllerEthnnicityButton(with: CWEthnicity(rawValue: CWEthnicity.RawValue(sender.tag)))
        }
    }
}
