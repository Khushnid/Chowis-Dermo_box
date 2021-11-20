//
//  Util.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/08/30.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    static let shared = Util()
    
    var latitude = ""
    var longitude = ""
    var temperature: Float = 24
    var humidity: Float = 23
    var uvIndex: Float = 12
    var token = ""
    
    func calcSkinTypeWithValueT(valueT: Int, U valueU: Int) -> String {
        
        var iRet = -1
        
        if valueT < 0 || valueU < 0 {
            
            return ""
        }
        
        if valueT >= 0 && valueU >= 0 {
            
            if valueT <= 5 {
                
                if valueU <= 5 {
                    
                    iRet = 0
                    
                } else if valueU <= 19 {
                    
                    iRet = 1
                    
                } else if valueU <= 30 {
                    
                    iRet = 2
                    
                } else if valueU <= 84 {
                    
                    iRet = 3
                    
                } else {
                    
                    iRet = 3
                }
                
            } else if valueT <= 19 {
                
                if valueU <= 5 {
                    
                    iRet = 1
                    
                } else if valueU <= 19 {
                    
                    iRet = 1
                    
                } else if valueU <= 30 {
                    
                    iRet = 2
                    
                } else if valueU <= 84 {
                    
                    iRet = 3
                    
                } else {
                    
                    iRet = 3
                }
                
            } else if valueT <= 30 {
                
                if valueU <= 5 {
                    
                    iRet = 1
                    
                } else if valueU <= 19 {
                    
                    iRet = 1
                    
                } else if valueU <= 30 {
                    
                    iRet = 2
                    
                } else if valueU <= 84 {
                    
                    iRet = 3
                    
                } else {
                    
                    iRet = 3
                }
                
            } else if valueT <= 84 {
                
                if valueU <= 5 {
                    
                    iRet = 5
                    
                } else if valueU <= 19 {
                    
                    iRet = 5
                    
                } else if valueU <= 30 {
                    
                    iRet = 5
                    
                } else if valueU <= 84 {
                    
                    iRet = 3
                    
                } else {
                    
                    iRet = 3
                }
                
            } else {
                
                if valueU <= 5 {
                    
                    iRet = 5
                    
                } else if valueU <= 19 {
                    
                    iRet = 5
                    
                } else if valueU <= 30 {
                    
                    iRet = 5
                    
                } else if valueU <= 84 {
                    
                    iRet = 3
                    
                } else {
                    
                    iRet = 4
                }
            }
            
        } else {
            
            if valueU <= 5 {
                
                iRet = 0
                
            } else if valueU <= 19 {
                
                iRet = 1
                
            } else if valueU <= 30 {
                
                iRet = 2
                
            } else if valueU <= 84 {
                
                iRet = 3
                
            } else {
                
                iRet = 4
            }
        }
        
        var strRet = ""
        
        if iRet == -1 {
            
            strRet = ""
            
        } else if iRet == 0 {
            
            strRet = "Very dry".localized
            
        } else if iRet == 1 {
            
            strRet = "Dry".localized
            
        } else if iRet == 2 {
            
            strRet = "Normal".localized
            
        } else if iRet == 3 {
            
            strRet = "Oily".localized
            
        } else if iRet == 4 {
            
            strRet = "Very Oily".localized
            
        } else if iRet == 5 {
            
            strRet = "Combination".localized
        }
        
        return strRet
    }
    
    var skinHealthQuestions = [
        
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none
    ]
    
    var skinSensitivityQuestions = [
        
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none,
        SkinSensitivityAnswer.none
    ]
    
    func getDescriptionShineMoistureValue(moistureValue: Int, oilValue: Int) -> String {
        
        var str = ""
        
        if moistureValue >= 0 && moistureValue <= 50 {
            
            if oilValue >= 0 && oilValue < 20 {
                
                str = "Lack of sebum and moisture → More moisture and oil required".localized
                
            } else if oilValue >= 20 && oilValue <= 30 {
                
                str = "Lack of moisture → More moisture required".localized
                
            } else if oilValue > 30 && oilValue <= 84 {
                
                str = "Oily skin with lack of moisture → More moisture and oil control care required".localized
                
            } else if oilValue > 84 {
                
                str = "Very oily skin with lack of moisture → More moisture and intensive oil care required".localized
            }
            
        } else if moistureValue > 50 {
            
            if oilValue >= 0 && oilValue < 20 {
               
                str = "Moisturized skin with lack of sebum → More oil required".localized
                
            } else if oilValue >= 20 && oilValue <= 30 {
                
                str = "Well-moisturized skin with no shiny → Perfect skin".localized
                
            } else if oilValue > 30 && oilValue <= 84 {
                
                str = "Oily and moisturized skin → Oil control care required".localized
                
            } else if oilValue > 84 {
                
                str = "Very oily and moisturized skin → Intensive oil care required".localized
            }
        }
        
        return str
    }
    
    var documentsURL: URL {
        
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func getImageFromDatabase(fileName: String) -> UIImage? {
        
        let fileURL = self.documentsURL.appendingPathComponent(fileName)
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            
            return UIImage(data: imageData)
            
        } catch {
            
            return nil
        }
    }
    
    func saveImageToDatabase(image: UIImage, fileName: String) -> Bool {
        
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
            return true
        }
        
        print("Error saving image")
        return false
    }
    
    func deleteImageFromDatabase(fileName: String) -> Bool {
        
        var filePath = ""
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        filePath = documentDirectory.appendingFormat("/" + fileName)
        
        do {
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                
                try fileManager.removeItem(atPath: filePath)
                return true
            } else {
                print("File does not exist")
                return false
            }

        } catch {
            
            return false
        }
    }
    
    func getCurrentLanguage() -> String {
         
        return defaults.object(forKey: CURRENT_LANGUAGE) as? String ?? "en"
    }
    
    func localize(key: String) -> String {
        
        return NSLocalizedString(key, bundle: getBundle(), comment: "")
    }
    
    func getBundle() -> Bundle {
            
        let language = getCurrentLanguage()
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            return Bundle(path: path) ?? Bundle.main
        }
        return Bundle.main
    }
    
    func getdocumentsdirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsdirectory = paths[0]
        return documentsdirectory
    }
    
    private func randomstring(_ length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    func savephototodocumentdirectory(imagedata:Data) -> String? {
        let phototoname = self.createImageName()
        let filemanager = FileManager.default
        let filepath = self.getFilePath(phototoname).absoluteString
        
        if filemanager.fileExists(atPath: filepath) {
                do {
                    try filemanager.removeItem(atPath: filepath)
                } catch {
                    return nil
                }
        }
        
        let videourl = self.getFilePath(phototoname)
        let writeResult = (imagedata as NSData).write(to: videourl, atomically: true)
        
        guard writeResult else { return nil }
        return phototoname
    }
    
    func createImageName() -> String {
        return "image_\(randomstring(80)).jpg"
    }
    
    func createTextName() -> String {
        return "txt_\(randomstring(80)).txt"
    }
    
    func getFilePath(_ fileName: String) -> URL {
        return getdocumentsdirectory().appendingPathComponent(fileName)
    }
    
    func getFilePath(_ fileName: String?) -> URL {
        return getdocumentsdirectory().appendingPathComponent(fileName.getOrDefault(""))
    }
    
    func formatToCWString(_ file: URL) -> String {
        let fileString = file.absoluteString
        let index = fileString.index(fileString.startIndex, offsetBy: 7)
        let outputFilePath = String(fileString[index...])
        return outputFilePath
    }
    
    func formatToCWString(_ file: String) -> String {
        let imagePath = getFilePath(file)
        return formatToCWString(imagePath)
    }
}
