//
//  GenderVC.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 4/26/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import UIKit
protocol GenderViewControllerDelegate: AnyObject {
    
    func didSelectGenderViewControllerNextButton()
    func didSelectGenderViewControllerCancelButton()
}

class GenderVC: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var titlelabel : UILabel!
    //MARK: - Properties
    var gender: String = ""
    var delegate: GenderViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        localizedString()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.femaleButton.layer.cornerRadius = 5
        self.maleButton.layer.cornerRadius = 5
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
    }
    
    func localizedString() {
        titlelabel.text = "GENDER".localized
        cancelButton.setTitle("Cancel".localized, for: .normal)
    }
    
    @IBAction func malePressed(_ sender: UIButton) {
        self.gender = "M"
        defaults.setValue(self.gender, forKey: USER_GENDER)
        delegate?.didSelectGenderViewControllerNextButton()
    }
    
    @IBAction func femalePressed(_ sender: UIButton) {
        self.gender = "F"
        defaults.setValue(self.gender, forKey: USER_GENDER)
        delegate?.didSelectGenderViewControllerNextButton()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectGenderViewControllerCancelButton()
        }
    }
}
