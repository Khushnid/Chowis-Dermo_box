//
//  SkinToneQuestionnaireViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/30.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol SkinToneQuestionnaireViewControllerDelegate: class {
    
    func didSelectSkinToneQuestionnaireViewControllerYesButtonPressed()
    func didSelectSkinToneQuestionnaireViewControllerNoButtonPressed()
}

class SkinToneQuestionnaireViewController: BaseViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var questionnaireDescriptionLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    weak var delegate: SkinToneQuestionnaireViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func updateLocalizedStrings() {
     
        self.titleLabel.text = "SKIN TONE QUESTIONNAIRE".uppercased().localized
        self.questionnaireDescriptionLabel.text = "This question are essential for the accuracy of the results of the analysis.".localized
        self.questionLabel.text = "Are you wearing make up?".localized
        
        self.yesButton.setTitle("YES".uppercased().localized, for: .normal)
        self.noButton.setTitle("NO".uppercased().localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.noButton.layer.borderWidth = 1
        self.yesButton.layer.borderWidth = 1
        
        self.noButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.yesButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        self.yesButton.layer.cornerRadius = self.yesButton.frame.size.height / 2
        self.noButton.layer.cornerRadius = self.noButton.frame.size.height / 2
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectSkinToneQuestionnaireViewControllerYesButtonPressed()
        }
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectSkinToneQuestionnaireViewControllerNoButtonPressed()
        }
    }
}
