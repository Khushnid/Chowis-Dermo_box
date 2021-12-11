//
//  ServiceManager.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/06.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import MobileCoreServices

public typealias Parameters = [String: Any]

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func getToken(id: String, password: String, appID: Int, completion: @escaping(String?, Error?) -> ()) {
        
        let _: HTTPHeaders = [:]
        let parameters: [String: Any] = [
            "id": id,
            "password": password,
            "appID": appID
        ]
        
        let URL_TOKEN = "http://3.22.242.142:3333/auth/getToken"
        
        AF.request(URL_TOKEN, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            
        }
    }
    
    func getImageFromUrl(url: String, completion: @escaping(UIImage) -> ()) {
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            
            do {
                
                if let data = response.data {
                    
                    let image = UIImage(data: data) ?? UIImage()
                    completion(image)
                    
                } else {
                    completion(UIImage())
                    print("Error - getImageFromUrl response: \(response)")
                }
            }
        }
    }
    
    func getOneCallWeatherInfoWith(location: CLLocation?, completion: @escaping(OneCallWeatherModel?, Error?) -> ()) {
        
        guard let location = location else { return }
        
        let parameters : Parameters = [
            "lat": location.coordinate.latitude,
            "lon": location.coordinate.longitude,
            "appid": API_KEY_WEATHER,
            "exclude": "minutely, hourly",
            "dt": Date().yesterday.toUnixTime,
            "units": "metric"
        ]
        
        AF.request(REQUEST_API_URL_ONECALL_WEATHER, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            
            do {
                
                let objects = try JSONDecoder().decode(OneCallWeatherModel.self , from: response.data ?? Data())
                completion(objects, nil)
                
            } catch {
                
                completion(nil, error)
            }
        }
    }
    
    func getCustomerInfo(phoneNumber: String?, completion: @escaping(CustomerInfoModel?, Error?) -> ()) {
        
        guard let phoneNumber = phoneNumber else { return }
        var path = phoneNumber
        path.remove(at: path.startIndex)
        path = "%2B" + path
        let endpoint: String = "?phone=\(path)"
        
        AF.request("\(REQUEST_API_URL_CUSTOMER_INFO)\(endpoint)", method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            do {
                let objects = try JSONDecoder().decode(CustomerInfoModel.self , from: response.data ?? Data())
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    func Doc(docData: Data?, id: Int, fileName: String, completion: @escaping(CustomerRespInfoModel?, Error?) -> ()) {
        let headers: HTTPHeaders = [
                  "Content-type": "multipart/form-data"
              ]
        var bodyKeyValue = [RequestBodyFormDataKeyvalue]()
        //let temp : String = String(id) ?? ""
        bodyKeyValue.append(RequestBodyFormDataKeyvalue(sKey: "id", sValue: String(id)))
        AF.upload(multipartFormData: { (multipartFormData) in
            
            if let data = docData{
                           multipartFormData.append(data, withName: "pdfFile", fileName: "DB_Pisga_iOS.pdf", mimeType: "application/pdf")
                       }
            for formData in bodyKeyValue {
                multipartFormData.append(Data(formData.sValue.utf8), withName: formData.sKey)
            }
            print(multipartFormData)
        }, to: RESPONSE_API_URL_CUSTOMER_INFO, method: .post, headers: headers)
        .responseJSON { (response) in
            print(response)
            do {
                let objects = try JSONDecoder().decode(CustomerRespInfoModel.self , from: response.data ?? Data())
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    do {
//                        let objects = try JSONDecoder().decode(CustomerRespInfoModel.self , from: response.data ?? Data())
//                        completion(objects, nil)
//                    } catch {
//                        completion(nil, error)
//                    }
//                }
//            case .failure(let error):
//                             print("Error in upload")
//
//            }
//        }
    }
//    func Do2c(url: String, docData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil, fileName: String, token : String!){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.33){
//
//            self.present(self.VC_loader, animated: false)
//        }
//         let headers: HTTPHeaders = [
//             "Content-type": "multipart/form-data",
//             "Token": "Bearer " + token
//         ]
//
//         print("Headers => \(headers)")
//
//         print("Server Url => \(url)")
//
//    //  Alamofire.upload(multipartFormData: <#T##(MultipartFormData) -> Void#>, to: <#T##URLConvertible#>, encodingCompletion: <#T##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##(SessionManager.MultipartFormDataEncodingResult) -> Void#>)
//
//         AF.upload(multipartFormData: { (multipartFormData) in
//             if let data = docData{
//                 multipartFormData.append(data, withName: "club_file", fileName: fileName, mimeType: "application/pdf")
//             }
//
//             for (key, value) in parameters {
//                 multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//              print("PARAMS => \(multipartFormData)")
//             }
//
//         }, to: url, method: .post, headers: headers) { (result) in
//             switch result{
//             case .success(let upload, _, _):
//                 upload.responseJSON { response in
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.33){
//                        self.VC_loader.dismiss(animated: false, completion: nil)
//                    }
//
//                     print("Succesfully uploaded")
//                     if let err = response.error{
//                         onError?(err)
//                         return
//                     }
//                     print(JSON(response.result.value as Any))
//                     onCompletion?(JSON(response.result.value as Any))
//                 }
//             case .failure(let error):
//                 print("Error in upload: \(error.localizedDescription)")
//                 onError?(error)
//             }
//         }
//     }
//    func sendPDFFile(id: Int, pdf: String) -> Bool {
//        let sUrl = RESPONSE_API_URL_CUSTOMER_INFO
//        var bodyKeyValue = [RequestBodyFormDataKeyvalue]()
//
//        var sampleRequest = URLRequest(url: URL(string: sUrl)!)
//        sampleRequest.httpMethod = HTTPMethod.post.rawValue
//        bodyKeyValue.append(RequestBodyFormDataKeyvalue(sKey: "id", sValue: id))
//        bodyKeyValue.append(RequestBodyFormDataKeyvalue(sKey: "pdfFile", sValue: pdf))
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//            for formData in bodyKeyValue {
//                multipartFormData.append(Data(formData.sValue), withName: formData.sKey)
//            }
//
//        }, to: sUrl, method: .post)
//        .uploadProgress{progress in
//            print(CGFloat(progress.fractionCompleted))
//        }
//        .response { response in
//            if (response.error == nil) {
//                var responseString : String
//                responseString = ""
//
//                if response.data != nil {
//                    responseString = String(bytes: response.data!, encoding: .utf8) ?? ""
//                } else {
//                    responseString = response.response?.description ?? ""
//                }
//                print(responseString ?? "")
//                print(response.response?.statusCode)
//
//                var responseData : NSData!
//
//                responseData = response.data! as NSData
//            }
//            return response.response?.statusCode ?? 1
//        }
////        guard let id = id else {  return  }
////        AF.request(RESPONSE_API_URL_CUSTOMER_INFO, method: .post, encoding: URLEncoding.default).responseJSON { (response) in
////            do {
////                let objects = try JSONDecoder().decode(CustomerRespInfoModel.self , from: response.data ?? Data())
////                completion(objects, nil)
////            } catch {
////                completion(nil, error)
////            }
////        }
//    }
    
    func uploadFFA(parameters: Parameters, uploadData: UploadDataModel, headers: HTTPHeaders = [], completion:@escaping (_ data: FFAModel?, _ error: String?) -> Void) {
        apiRequestBatchID(completion: { _, _ in
            self.apiRequestUploadWithBatchID(REQUEST_API_URL_FFA_ONECALL_DIAGNOSIS, uploadData: uploadData, parameters: parameters, type: FFAModel.self, method: .post, headers: headers, completion: { result, error in completion(result, error) })
        })
    }
    
    func apiRequestUploadWithBatchID <T: Codable>(_ url: String, uploadData: UploadDataModel, parameters: Parameters, type: T.Type, parameter: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders = [], completion: @escaping (T?, String?)->Void) {
        if CurrentUser.shared.batchID < 0 {
            apiRequestBatchID(completion: { _, _ in
                self.apiRequestUploadWithBatchID(url, uploadData: uploadData, parameters: parameters, type: type.self, method: method, headers: headers, completion: { result, error in completion(result, error) })
            })
        } else {
            var headers = headers
            headers.add(name: "batch_id", value: "\(CurrentUser.shared.batchID)")
            self.apiRequestUploadWithToken(url, uploadData: uploadData, parameters: parameters, type: type.self, method: method, headers: headers, completion: { result, error in completion(result, error) })
        }
    }
    
    func apiRequestUploadWithToken<T: Codable>(_ url: String, uploadData: UploadDataModel, parameters: Parameters, type: T.Type, parameter: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders = [], completion: @escaping (T?, String?)->Void) {
        apiRequestToken(completion: { tokenID, error in
            var headers = headers
            headers.add(name: "access_token", value: tokenID)
            headers.add(name: "app_id", value: "\(App.app_id)")
            
            self.apiRequestUpload(url, uploadData: uploadData, parameters: parameters, type: type.self, method: method, headers: headers, completion: { result, error in completion(result, error) })
        })
    }
    
    func apiRequestUpload<T: Codable>(_ url: String, uploadData: UploadDataModel, parameters: Parameters, type: T.Type, parameter: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, completion: @escaping (T?, String?)->Void) {
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let value = "\(value)".data(using: .utf8) {
                    multipartFormData.append(value, withName: key)
                }
            }
            multipartFormData.append(uploadData.data, withName: uploadData.name, fileName: uploadData.fileName, mimeType: uploadData.mimeType)
        },
        to: url,
        method: method,
        headers: headers) { $0.timeoutInterval = 200 }
        .uploadProgress(closure: { progress in })
        .responseDecodable(of: type.self) { (response) in
            switch response.result {
            case .success(let result):
                completion(result, nil)
                break
            case .failure(let error):
                print("ERROR: ", error)
                completion(nil, error.localizedDescription)
                break
            }
        }
    }
    
    private func apiRequestBatchID(_ url: String = REQUEST_API_URL_REQUEST_BATCH_ID, method: HTTPMethod = .get, completion: @escaping (BatchIDModel?, String?)->Void) {
        apiDecodableRequestWithToken(url, type: BatchIDModel.self, method: method, completion: { result, error in
            if let batchID = result?.batchID {
                CurrentUser.shared.batchID = batchID
                completion(result, error)
            } else {
                self.apiRequestBatchID(completion: { result, error in completion(result, error) })
            }
        })
    }
    
    func apiDecodableRequestWithToken<T: Codable>(_ url: String, type: T.Type, parameter: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders = [], completion: @escaping (T?, String?)->Void) {
        apiRequestToken(completion: { tokenID, error in
            var headers = headers
            headers.add(name: "access_token", value: tokenID)
            headers.add(name: "app_id", value: "\(App.app_id)")
            self.apiDecodableRequest(url, type: type.self, parameter: parameter, method: method, headers: headers, completion: { result, error in completion(result, error)})
        })
    }
    
    private func apiRequestToken(_ url: String = REQUEST_API_URL_TOKEN, method: HTTPMethod = .post, completion: @escaping (String, String?)->Void) {
        let parameter: Parameters = [
            "id": App.id,
            "password": App.password,
            "app_id": App.app_id
        ]
        apiDecodableRequest(url, type: ApiTokenModel.self, parameter: parameter, method: method, completion: { result, error in
            if let accessToken = result?.accessToken {
                CurrentUser.shared.tokenID = accessToken
                completion(accessToken, error)
            } else {
                self.apiRequestToken(completion: { result, error in completion(result, error) })
            }
        })
    }
    
    func apiDecodableRequest<T: Codable>(_ url: String, type: T.Type, parameter: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, completion: @escaping (T?, String?)->Void) {
        AF.request(url, method: method, parameters: parameter, headers: headers)
            .responseDecodable(of: type.self) { (response) in
                switch response.result {
                case .success(let result):
                    completion(result, nil)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error.localizedDescription)
                    break
                }
            }
    }
    
    func download(_ url: String, destination: DownloadRequest.Destination? = nil, completion:@escaping (_ result: AFDownloadResponse<URL?>) -> Void) {
        self.apiRequestDownload(url, destination: destination, method: .post, completion: { result in completion(result) })
    }
    
    func apiRequestDownload(_ url: String, destination: DownloadRequest.Destination? = nil, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, completion: @escaping (AFDownloadResponse<URL?>)->Void) {
        AF.download(url, to: destination).response { response in
            completion(response)
        }
    }
}
