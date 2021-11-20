//
//  Constants.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/08/23.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation
import UIKit

class Device {
    static let guid = "app_guid"
    static let osVersion = "app_osversion"
    static let platform = "ios"
    static let version = "app_version"
    static let whatsNewData = "app_whatsnewdata"
    static let os = "\(Device.platform)\(UIDevice().systemVersion)"
    static let date = Date()
}

class App {
    static let id = "sw9w691jvet8xwu7"
    static let password = "3ksng2m0ejd43yjt"
    static let app_id = 42
}


public let defaults = UserDefaults.standard
public let WIFI_MODE = "WIFI_MODE"
public let CONNECTION_ICON = "CONNECTION_ICON"
public let REQUEST_API_URL_CUSTOMER_INFO = "http://app.dermabox.co.il/api/User/requesCustomerData"
public let RESPONSE_API_URL_CUSTOMER_INFO = "http://app.dermabox.co.il:80/api/User/responseCustomerData"
public let API_KEY_WEATHER = "83dba829d2758b59b28390a0d1daad93"
public let REQUEST_API_URL_ONECALL_WEATHER = "http://api.openweathermap.org/data/2.5/onecall"
public let REQUEST_API_URL_ONECALL_TIMEMACHINE_WEATHER = "http://api.openweathermap.org/data/2.5/onecall/timemachine"
public let REQUEST_API_URL_WEATHER = "http://api.openweathermap.org/data/2.5/weather"
public let REQUEST_API_URL_WEATHER_UV = "http://api.openweathermap.org/data/2.5/uvi"
public let OPTIC_NUMBER = "OPTIC_NUMBER"
public let SERIAL_NUMBER = "SERIAL_NUMBER"
public let EMAIL_ADDRESS = "EMAIL_ADDRESS"
public let PHONE_NUMBER = "PHONE_NUMBER"
public let COMPANY_PASSWORD = "COMPANY_PASSWORD"
public let CURRENT_LANGUAGE = "CURRENT_LANGUAGE"

public let USER_ID = "USER_ID"
public let USER_FIRST_NAME = "USER_FIRST_NAME"
public let USER_LAST_NAME = "USER_LAST_NAME"
public let USER_EMAIL_ADDRESS = "USER_EMAIL_ADDRESS"
public let USER_PASSWORD = "USER_PASSWORD"
public let USER_BIRTHDAY = "USER_BIRTHDAY"
public let USER_ETHNICITY = "USER_ETHNICITY"
public let USER_PHONE_NUMBER = "USER_PHONE_NUMBER"
public let USER_SKIN_COLOR_GROUP = "USER_SKIN_COLOR_GROUP"
public let USER_GENDER = "USER_GENDER"
public let SEBUM_MODE = "SEBUM_MODE"
public let FULL_FACIAL_ANALYSIS = "FULL_FACIAL_ANALYSIS"
public let AUTO_IMAGE_CAPTURE = "AUTO_IMAGE_CAPTURE"
public let RESULTS_DISPLAY = "RESULTS_DISPLAY"
public let ANALYSIS_RESULTS_REVIEW = "ANALYSIS_RESULTS_REVIEW"
public let AP_MODE_SSID = "AP_MODE_SSID"
public let AP_MODE_PASSWORD = "AP_MODE_PASSWORD"
public let DID_CHANGE_DEVICE_MODE = "DID_CHANGE_DEVICE_MODE"

public let SHOULD_SHOW_PORES_GUIDE = "SHOULD_SHOW_PORES_GUIDE"
public let SHOULD_SHOW_SPOTS_GUIDE = "SHOULD_SHOW_SPOTS_GUIDE"
public let SHOULD_SHOW_WRINKLES_GUIDE = "SHOULD_SHOW_WRINKLES_GUIDE"
public let SHOULD_SHOW_IMPURITIES_GUIDE = "SHOULD_SHOW_IMPURITIES_GUIDE"
public let SHOULD_SHOW_KERATIN_GUIDE = "SHOULD_SHOW_KERATIN_GUIDE"
public let SHOULD_SHOW_SEBUM_GUIDE = "SHOULD_SHOW_SEBUM_M_GUIDE"
public let SHOULD_SHOW_MOISTURE_GUIDE = "SHOULD_SHOW_SEBUM_O_GUIDE"

// MARK: - URLs for FFA diagnosis
public let API_ANALYSIS_URL = "http://52.14.217.107"
public let API_FFA_URL = "http://ffa.chowis.com:3020" //"http://3.22.242.142:3020"
public let REQUEST_API_URL_FFA_GET_LIST = "\(API_FFA_URL)/algorithm/getListAlgorithm"
public let REQUEST_API_URL_FFA_DIAGNOSIS = "\(API_FFA_URL)/analysis/requestFFAAnalysis"
public let REQUEST_API_URL_FFA_ONECALL_DIAGNOSIS = "\(API_FFA_URL)/algorithm/requestFFAUnifiedAnalysisMask"
public let REQUEST_API_URL_REQUEST_BATCH_ID = "\(API_FFA_URL)/analysis/requestBatchID"
public let FFA_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6Im1hcmsiLCJpYXQiOjE1ODg0OTcyMTMsImV4cCI6MTU5NjI3MzIxM30.EBOApgDLapZvwj12FQoumf0FULUpUyD7OUwNxp2YJ-s"
public let MESSAGE_FFA_FINISHED = Notification.Name("MESSAGE_FFA_FINISHED")

public let API_TOKEN_URL = API_ANALYSIS_URL + ":3333" //"http://3.22.242.142:3333"
public let REQUEST_API_URL_TOKEN = "\(API_TOKEN_URL)/auth/getToken"

public let skinColorSG1 = UIColor(red: 0.9450980392, green: 0.8588235294, blue: 0.8, alpha: 1)
public let skinColorSG2 = UIColor(red: 0.8980392157, green: 0.7882352941, blue: 0.6941176471, alpha: 1)
public let skinColorSG3 = UIColor(red: 0.8196078431, green: 0.7098039216, blue: 0.5764705882, alpha: 1)
public let skinColorSG4 = UIColor(red: 0.7529411765, green: 0.6156862745, blue: 0.5215686275, alpha: 1)
public let skinColorSG5 = UIColor(red: 0.4196078431, green: 0.2431372549, blue: 0.1411764706, alpha: 1)
public let skinColorSG6 = UIColor(red: 0.2470588235, green: 0.168627451, blue: 0.1254901961, alpha: 1)
