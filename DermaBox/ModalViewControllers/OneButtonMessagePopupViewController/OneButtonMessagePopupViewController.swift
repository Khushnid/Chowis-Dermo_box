//
//  OneButtonMessagePopupViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/03.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit


protocol OneButtonMessagePopupViewControllerDelegate: class {
    
    func didSelectOneButtonMessagePopupOkPressed()
}

class OneButtonMessagePopupViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    
    var titleText:String?
    var messageText:String?
    var saveButtonText:String?
    var iconImage:UIImage?
    
    weak var delegate: OneButtonMessagePopupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleText = self.titleText {
            
            self.titleLabel.text = titleText
        }
        
        if let messageText = self.messageText {
            
            self.messageLabel.text = messageText
        }
        
        if let saveButtonText = self.saveButtonText {
            
            self.saveButton.setTitle(saveButtonText, for: .normal)
        }
        
        if let iconImage = self.iconImage {
            
            self.iconImageView.image = iconImage
        
        } else {
        
            self.iconImageView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 2
        self.saveButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.saveButton.frame.size.height / 2)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectOneButtonMessagePopupOkPressed()
        }
    }
    
}
