//
//  LanguageViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/25.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class LanguageViewController: BaseViewController {
    
    @IBOutlet var languageTitleLabel: UILabel!
    @IBOutlet var englishButton: UIButton!
    @IBOutlet var hebrewButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    var selectedLanguage = ""
    
    let defaultButtonColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
    let selectedButtonColor = #colorLiteral(red: 0.203894943, green: 0.2039368749, blue: 0.2038923204, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.localizeStrings()
        self.customizeSaveButton()
    }
    
    fileprivate func localizeStrings() {
        
        self.saveButton.setTitle("SAVE".localized, for: .normal)
        self.languageTitleLabel.text = "Language Settings".localized
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button: UIButton? in [

            self.englishButton,
            self.hebrewButton,
            self.saveButton] {
            
            button?.layer.cornerRadius = self.englishButton.frame.size.height / 2
        }
        
        for button: UIButton? in [
            self.englishButton,
            self.saveButton] {
            
            button?.layer.cornerRadius = self.englishButton.frame.size.height / 2
            button?.backgroundColor = self.defaultButtonColor
        }
        
        let language: String = defaults.value(forKey: CURRENT_LANGUAGE) as? String ?? "en"
        
        switch language {
        case "en":
            self.englishButton.isSelected = false
            self.englishButton.backgroundColor = self.selectedButtonColor
            break
        case "he":
            self.hebrewButton.isSelected = false
            self.hebrewButton.backgroundColor = self.selectedButtonColor
            break
        default:
            self.englishButton.isSelected = false
            self.englishButton.backgroundColor = self.selectedButtonColor
            break
        }
    }
    
    @IBAction func languageButtonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 3:
            self.selectedLanguage = "en"
            break
        case 4:
            self.selectedLanguage = "he"
            break
        default:
            self.selectedLanguage = "en"
            break
        }
        
        if sender.isSelected {
            return
        }
        
        for button: UIButton? in [
            self.hebrewButton,
            self.englishButton] {
            
            button?.isSelected = false
            button?.backgroundColor = self.defaultButtonColor
            
        }
        
        sender.isSelected = false
        sender.backgroundColor = self.selectedButtonColor
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveButton.layer.removeAllAnimations()
        defaults.set(self.selectedLanguage, forKey: CURRENT_LANGUAGE)
        defaults.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func customizeSaveButton() {
        self.saveButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.saveButton.frame.size.height / 2)
    }
}
