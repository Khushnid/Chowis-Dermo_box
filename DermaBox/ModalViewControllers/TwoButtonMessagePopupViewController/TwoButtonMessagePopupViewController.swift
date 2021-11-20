//
//  TwoButtonMessagePopupViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/20.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol TwoButtonMessagePopupViewControllerDelegate: class {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed()
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed()
}

class TwoButtonMessagePopupViewController: BaseViewController {

    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    
    var titleText: String?
    var messageText: String?
    var rightButtonText: String?
    var leftButtonText: String?
    
    weak var delegate: TwoButtonMessagePopupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noticeLabel.text = titleText
        self.messageLabel.text = messageText
        self.rightButton.setTitle(rightButtonText, for: .normal)
        self.leftButton.setTitle(leftButtonText, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.leftButton.layer.cornerRadius = self.leftButton.frame.size.height / 2
        self.rightButton.layer.cornerRadius = self.rightButton.frame.size.height / 2
        
        self.leftButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.leftButton.frame.size.height / 2)
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectTwoButtonMessagePopupViewControllerRightButtonPressed()
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed()
        }
    }
}
