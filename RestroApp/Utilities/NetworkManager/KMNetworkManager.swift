//
//  W3NetworkManager.swift
//  Khalid Moin
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid. All rights reserved.

import Foundation

import UIKit
import Alamofire

public enum kHTTPMethod: String {
    case GET
}

public enum ErrorType: Error {
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class KMNetworkManager
{

    internal static let sharedInstance: KMNetworkManager =
    {
        return KMNetworkManager()
    }()
    
    

    func requestApi(withServiceName serviceName: String, requestMethod method: kHTTPMethod, requestParameters postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool, baseURL:String, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            if showProgress
            {
                CommonUtils.showHudWithNoInteraction(show: true)
            }
            
            let headers = getHeaderWithAPIName(serviceName: serviceName)
            
            let serviceUrl = getServiceUrl(serviceString: serviceName, baseUrl: baseURL)
            
            let params  = getPrintableParamsFromJson(postData: postData)
            
            print("Connecting to Host with URL \(baseURL)\(serviceName) with parameters: \(params)")
            
            //NSAssert Statements            assert(method != .GET, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            switch method
            {
            case .GET:
                AF.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                                                                                                                                            { (DataResponse) in
                    CommonUtils.showHudWithNoInteraction(show: false)
                    switch DataResponse.result
                    {
                    case .success(_):
                        let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                        completionClosure(response.responseData, response.error, .requestSuccess,Int.getInt(DataResponse.response?.statusCode))
                    case .failure(let error):
                        print("json error: \(error.localizedDescription)")
                        if DataResponse.response?.statusCode == 401 {
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        } else {
                            if error.localizedDescription == "cancelled"
                            {
                                completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                            }
                            else
                            {
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                        }
                    }
                })
            }
        }
        else
        {
            CommonUtils.showHudWithNoInteraction(show: false)
            CommonUtils.showToast(message: "Please Check your Network Connection!")
        }
    }
    
    private func getHeaderWithAPIName(serviceName: String) -> HTTPHeaders {
        let headers:HTTPHeaders = [:]
        return headers
    }
    
    private func getServiceUrl(serviceString: String, baseUrl:String) -> String{
        if serviceString.contains("http"){
            return serviceString
        }
        else{
            return baseUrl + serviceString
        }
    }
    
    private func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String
    {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.utf8)
            return theJSONText ?? ""
        }
        catch let error as NSError
        {
            print(error)
            return ""
        }
    }
    
    private func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
            print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        }
        catch let error
        {
            return (nil, error)
        }
    }
}
