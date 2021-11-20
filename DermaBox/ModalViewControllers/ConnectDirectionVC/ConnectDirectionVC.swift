//
//  ConnectDirectionVC.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/11/15.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

protocol ConnectDirectionVCDelegate {
    
    func didSelectConnectDirectionVCConnectButton(isApMode: Bool)
}

class ConnectDirectionVC: BaseViewController {

    
    //MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var connectionLabel: UILabel!
    
    //MARK: - Properties
    var delagte: ConnectDirectionVCDelegate?
    var isApMode: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isApMode {
            
            self.descriptionLabel.text = "This setup gives you access to the internet while connected to the Analyzer"
            self.connectionLabel.text = "Add Connection"
            
        } else {
            
            self.descriptionLabel.text = "By tapping 'Add Device', it will redirect to WiF settings page and connect to the device directly.\n\nMake sure your analyzer is turned on for the name to be detected.\n\nSelect on your analyzer name, input analyzer's password and connect."
            self.connectionLabel.text = "Add Device"
        }
    }
    
    @IBAction func connectionButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.delagte?.didSelectConnectDirectionVCConnectButton(isApMode: self.isApMode)
        }
    }
}
