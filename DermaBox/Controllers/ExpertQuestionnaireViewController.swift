//
//  ExpertQuestionnaireViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/30.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

enum SkinSensitivityAnswer {

    case none
    case one
    case two
    case three
    case four
}

enum QuestionType {
    
    case skinHealth
    case skinSensitivity
}

class ExpertQuestionnaireViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var fourthButton: UIButton!
    
    var questionType:QuestionType = .skinHealth
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.index = 0
        self.getSkinHealthQuestionWithIndex(index: index)
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
    
        if self.questionType == .skinHealth {
            
            let questionIndex = self.index - 1
            
            if questionIndex < Util.shared.skinHealthQuestions.count {
                
                if sender.tag == 0 {
                    
                    Util.shared.skinHealthQuestions[questionIndex] = .one
                    
                } else if sender.tag == 1 {
                    
                    Util.shared.skinHealthQuestions[questionIndex] = .two
                    
                } else if sender.tag == 2 {
                    
                    Util.shared.skinHealthQuestions[questionIndex] = .three
                    
                } else if sender.tag == 3 {
                    
                    Util.shared.skinHealthQuestions[questionIndex] = .four
                    
                } else {
                    
                    Util.shared.skinHealthQuestions[questionIndex] = .none
                }
            }
        
            self.getSkinHealthQuestionWithIndex(index: index)
            
        } else {
            
            let questionIndex = self.index - 1
            
            if questionIndex < Util.shared.skinSensitivityQuestions.count {
                
                if sender.tag == 0 {
                    
                    Util.shared.skinSensitivityQuestions[questionIndex] = .one
                    
                } else if sender.tag == 1 {
                    
                    Util.shared.skinSensitivityQuestions[questionIndex] = .two
                    
                } else if sender.tag == 2 {
                    
                    Util.shared.skinSensitivityQuestions[questionIndex] = .three
                    
                } else if sender.tag == 3 {
                    
                    Util.shared.skinSensitivityQuestions[questionIndex] = .four
                    
                } else {
                    
                    Util.shared.skinSensitivityQuestions[questionIndex] = .none
                }
            }
            
            self.getSkinSensitivityQuestionWithIndex(index: index)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.firstButton.layer.borderWidth = 1
        self.secondButton.layer.borderWidth = 1
        self.thirdButton.layer.borderWidth = 1
        self.fourthButton.layer.borderWidth = 1
        
        self.firstButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.secondButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.thirdButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.fourthButton.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        self.firstButton.layer.cornerRadius = self.firstButton.frame.size.height / 2
        self.secondButton.layer.cornerRadius = self.secondButton.frame.size.height / 2
        self.thirdButton.layer.cornerRadius = self.thirdButton.frame.size.height / 2
        self.fourthButton.layer.cornerRadius = self.fourthButton.frame.size.height / 2
    }
    
    func getSkinHealthQuestionWithIndex(index: Int) {
     
        self.fourthButton.isHidden = true
        self.titleLabel.text = "SKIN HEALTH".localized
        var question = ""
        var answerOne = ""
        var answeTwo = ""
        var answeThree = ""
        
        if index == 0 {
            
            question = "How much water do you drink these days?".localized
            answerOne = "8 or more cups".localized
            answeTwo = "4-6 cups".localized
            answeThree = "3 or less cups".localized
        
        } else if index == 1 {
            
            question = "How much coffee do you drink these days? ".localized
            answerOne = "1 cup or less".localized
            answeTwo = "2-3 cups".localized
            answeThree = "4 or more cups".localized
        
        } else if index == 2 {
            
            question = "Do you wear sun-protection products?".localized
            answerOne = "Yes".localized
            answeTwo = "Yes, but not always".localized
            answeThree = "No".localized
            
        } else if index == 3 {
            
            question = "How many times a day do you clean and moisturize your skin?".localized
            answerOne = "2 times a day".localized
            answeTwo = "One time a day".localized
            answeThree = "Not regular".localized
            
        } else if index == 4 {
            
            question = "Do you have evenly toned skin?".localized
            answerOne = "Yes".localized
            answeTwo = "Yes, but I have some pigmentation (spots)".localized
            answeThree = "No, I have spots and dark circles".localized
        }
        
        if index == 5 {
            
            self.questionType = .skinSensitivity
            self.index = 0
            self.getSkinSensitivityQuestionWithIndex(index: self.index)
            
        } else {
            
            self.counterLabel.text = "0\(index + 1) / 05"
            self.questionLabel.text = question
            self.firstButton.setTitle(answerOne, for: .normal)
            self.secondButton.setTitle(answeTwo, for: .normal)
            self.thirdButton.setTitle(answeThree, for: .normal)
            self.index = self.index + 1
        }
    }
    
    func getSkinSensitivityQuestionWithIndex(index: Int) {
        
        self.fourthButton.isHidden = false
        self.titleLabel.text = "SKIN SENSITIVITY".localized
        
        var question = ""
        
        if index == 0 {
            
            question = "Over the last month, how stinging, itchy, sore, or painful has your skin been?".localized
        
        } else if index == 1 {
            
            question = "Over the last month, how embarrassed or self-conscious have you been because of your skin?".localized
        
        } else if index == 2 {
            
            question = "Over the last month, how much has your skin prevented you from studying or working at home?".localized
            
        } else if index == 3 {
            
            question = "Over the last month, how much has the sensitivity of your skin influenced the clothes you wear?".localized
            
        } else if index == 4 {
            
            question = "Over the last month, how much has your skin affected any social or leisure or sports activities?".localized
        
        } else if index == 5 {
            
            question = "Over the last month, how much time and effort has your skin treatment taken?".localized
            
        } else if index == 6 {
            
            question = "Do you experience skin issues during the environment change?".localized
            
        } else if index == 7 {
            
            question = "Do you experience skin issues when you change your skin products?".localized
        }
        
        if index == 8 {
            
            self.performSegue(withIdentifier: "GoToAnalysisVC", sender: self)
        
        } else {
         
            self.counterLabel.text = "0\(index + 1) / 08"
            self.questionLabel.text = question
            self.firstButton.setTitle("Very much".localized, for: .normal)
            self.secondButton.setTitle("A lot".localized, for: .normal)
            self.thirdButton.setTitle("A little".localized, for: .normal)
            self.fourthButton.setTitle("Not at all".localized, for: .normal)
            
            self.index = self.index + 1
        }
    }
}
