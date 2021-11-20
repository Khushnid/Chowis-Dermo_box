//
//  BirthDayViewController.swift
//  DermoPicoSkin
//
//  Created by Bekzod Rakhmatov on 05/05/2019.
//  Copyright © 2019 Chowis. All rights reserved.
//

import UIKit

protocol BirthDayViewControllerDelegate: class {
    
    func didSelectBirthDayViewControllerSaveButton(with birthday: String)
}

class BirthDayViewController: BaseViewController {
    
    @IBOutlet var birthdayTitleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var customerDate: String = ""
    weak var delegate: BirthDayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.datePicker.date = formatter.date(from: customerDate) ?? Date()
        self.datePicker.maximumDate = Date()

        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.birthdayTitleLabel.text = "BIRTHDAY".localized
        self.saveButton.setTitle("SAVE".localized, for: .normal)
        self.cancelButton.setTitle("CANCEL".localized, for: .normal)
    }

    override func viewDidLayoutSubviews() {
        
        self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let diagnosisDate = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
   
        let customerBirthDay: String = formatter.string(from: diagnosisDate)
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectBirthDayViewControllerSaveButton(with: customerBirthDay)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
