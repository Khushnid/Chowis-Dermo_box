//
//  SkinColorGroupViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/26.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK

protocol SkinColorGroupViewControllerDelegate: AnyObject {
    
    func didSelectSkinColorGroupViewControllerSkinColorGroupButton(with cwSkinScalpColorType: CWSkinScalpColorType)
}

class SkinColorGroupViewController: BaseViewController {
    
    @IBOutlet var skinColorGroupTitleLabel: UILabel!
    @IBOutlet var sg1Button: UIButton!
    @IBOutlet var sg2Button: UIButton!
    @IBOutlet var sg3Button: UIButton!
    @IBOutlet var sg4Button: UIButton!
    @IBOutlet var sg5Button: UIButton!
    @IBOutlet var sg6Button: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    weak var delegate: SkinColorGroupViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sg1Button.backgroundColor = skinColorSG1
        self.sg2Button.backgroundColor = skinColorSG2
        self.sg3Button.backgroundColor = skinColorSG3
        self.sg4Button.backgroundColor = skinColorSG4
        self.sg5Button.backgroundColor = skinColorSG5
        self.sg6Button.backgroundColor = skinColorSG6
        
        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.skinColorGroupTitleLabel.text = "SKIN COLOR GROUP".localized
        self.sg1Button.setTitle("SG1".localized, for: .normal)
        self.sg2Button.setTitle("SG2".localized, for: .normal)
        self.sg3Button.setTitle("SG3".localized, for: .normal)
        self.sg4Button.setTitle("SG4".localized, for: .normal)
        self.sg5Button.setTitle("SG5".localized, for: .normal)
        self.sg6Button.setTitle("SG6".localized, for: .normal)
        self.cancelButton.setTitle("CANCEL".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //let borderColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.sg1Button.layer.cornerRadius = self.sg1Button.frame.size.height / 2
        self.sg2Button.layer.cornerRadius = self.sg2Button.frame.size.height / 2
        self.sg3Button.layer.cornerRadius = self.sg3Button.frame.size.height / 2
        self.sg4Button.layer.cornerRadius = self.sg4Button.frame.size.height / 2
        self.sg5Button.layer.cornerRadius = self.sg5Button.frame.size.height / 2
        self.sg6Button.layer.cornerRadius = self.sg6Button.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
    }
    
    @IBAction func skinColorButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectSkinColorGroupViewControllerSkinColorGroupButton(with: CWSkinScalpColorType(rawValue: CWSkinScalpColorType.RawValue(sender.tag)))
        }
    }
}
