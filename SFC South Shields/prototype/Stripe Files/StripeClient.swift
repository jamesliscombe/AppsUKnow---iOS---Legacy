//
//  StripeClient.swift
//  prototype
//
//  Created by James Liscombe on 11/09/2018.
//  Copyright © 2018 appsuknow. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

enum Result {
    case successChargeDelivery201
    case successChargeCollection202
    case successCashDelivery203
    case successCashCollection204
    case badRequestException306
    case unauthorised307
    case invalidRequest308
    case notFound309
    case cardError310
    case serverError311
    case amountMismatch312
    case failure(Error)
}

final class StripeClient {
    
    static let shared = StripeClient()
    
    private init() {
        // private
    }
    
    private lazy var baseURL: URL = {
        guard let url = URL(string: Constants.baseURLString) else {
            fatalError("Invalid URL")
        }
        return url
    }()
    
    func completeChargeDelivery(with token: STPToken, amount: Double, note: String, time: String, name: String, phoneNumber: String, email: String, street: String, city: String, postcode: String, method: Bool, singleItems: [String:Int], multiItems: [String:Int], deviceToken: String, ios: Int, completion: @escaping (Result) -> Void) {
        let url = baseURL.appendingPathComponent("charge")
        
        var deals = [String]()
        var choices = [String]()
        
        
        for (deal) in BasketArrays.deals {
            deals.append(deal.name!)
            for(choice) in deal.choices! {
                choices.append(deal.name! + " : " + choice)
            }
        }
        
        let params: [String: Any] = [
            "token": token.tokenId,
            "amount": amount,
            "currency": Constants.defaultCurrency,
            "description": Constants.defaultDescription,
            "note": note,
            "delivery": "Delivery",
            "time": time,
            "name": name,
            "phoneNumber": phoneNumber,
            "email":email,
            "street": street,
            "city": city,
            "postcode": postcode,
            "singleItems": BasketArrays.singleItems,
            "multiItems": BasketArrays.multiItems,
            "deals": deals,
            "choices": choices,
            "card": method,
            "deviceToken":deviceToken,
            "ios":ios
        ]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.response!.statusCode {
                case 201:
                    completion(Result.successChargeDelivery201)
                case 202:
                    completion(Result.successChargeCollection202)
                case 203:
                    completion(Result.successCashDelivery203)
                case 204:
                    completion(Result.successCashCollection204)
                case 306:
                    completion(Result.badRequestException306)
                case 307:
                    completion(Result.unauthorised307)
                case 308:
                    completion(Result.invalidRequest308)
                case 309:
                    completion(Result.notFound309)
                case 310:
                    completion(Result.cardError310)
                case 311:
                    completion(Result.serverError311)
                case 312:
                    completion(Result.amountMismatch312)
                default:
                    completion(Result.failure(response.error!))
                }
        }
    }
    
    func completeChargeCollection(with token: STPToken, amount: Double, note: String, time: String, name: String, phoneNumber: String, email: String, method: Bool, singleItems: [String:Int], multiItems: [String:Int], deviceToken: String, ios: Int, completion: @escaping (Result) -> Void) {
        let url = baseURL.appendingPathComponent("charge")
        
        var deals = [String]()
        var choices = [String]()
        
        
        for (deal) in BasketArrays.deals {
            deals.append(deal.name!)
            for(choice) in deal.choices! {
                choices.append(deal.name! + " : " + choice)
            }
        }
        
        let params: [String: Any] = [
            "token": token.tokenId,
            "amount": amount,
            "currency": Constants.defaultCurrency,
            "description": Constants.defaultDescription,
            "note": note,
            "delivery": "Collection",
            "time": time,
            "name": name,
            "phoneNumber": phoneNumber,
            "email":email,
            "singleItems": BasketArrays.singleItems,
            "multiItems": BasketArrays.multiItems,
            "deals": deals,
            "choices": choices,
            "card": method,
            "deviceToken":deviceToken,
            "ios":ios
        ]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.response!.statusCode {
                case 201:
                    completion(Result.successChargeDelivery201)
                case 202:
                    completion(Result.successChargeCollection202)
                case 203:
                    completion(Result.successCashDelivery203)
                case 204:
                    completion(Result.successCashCollection204)
                case 306:
                    completion(Result.badRequestException306)
                case 307:
                    completion(Result.unauthorised307)
                case 308:
                    completion(Result.invalidRequest308)
                case 309:
                    completion(Result.notFound309)
                case 310:
                    completion(Result.cardError310)
                case 311:
                    completion(Result.serverError311)
                case 312:
                    completion(Result.amountMismatch312)
                default:
                    completion(Result.failure(response.error!))
                }
        }
    }
    
    //Cash
    func completeCashDelivery(with amount: Double, note: String, time: String, name: String, phoneNumber: String, email: String, street: String, city: String, postcode: String, method: Bool, singleItems: [String:Int], multiItems: [String:Int], deviceToken: String, ios: Int, completion: @escaping (Result) -> Void) {
        let url = baseURL.appendingPathComponent("charge")
        
        var deals = [String]()
        var choices = [String]()
        
        
        for (deal) in BasketArrays.deals {
            deals.append(deal.name!)
            for(choice) in deal.choices! {
                choices.append(deal.name! + " : " + choice)
            }
        }
        
        let params: [String: Any] = [
            "amount": amount,
            "currency": Constants.defaultCurrency,
            "description": Constants.defaultDescription,
            "note": note,
            "delivery": "Delivery",
            "time": time,
            "name": name,
            "phoneNumber": phoneNumber,
            "email":email,
            "street": street,
            "city": city,
            "postcode": postcode,
            "singleItems": BasketArrays.singleItems,
            "multiItems": BasketArrays.multiItems,
            "deals": deals,
            "choices": choices,
            "card": method,
            "deviceToken":deviceToken,
            "ios":ios
        ]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.response!.statusCode {
                case 201:
                    completion(Result.successChargeDelivery201)
                case 202:
                    completion(Result.successChargeCollection202)
                case 203:
                    completion(Result.successCashDelivery203)
                case 204:
                    completion(Result.successCashCollection204)
                case 306:
                    completion(Result.badRequestException306)
                case 307:
                    completion(Result.unauthorised307)
                case 308:
                    completion(Result.invalidRequest308)
                case 309:
                    completion(Result.notFound309)
                case 310:
                    completion(Result.cardError310)
                case 311:
                    completion(Result.serverError311)
                case 312:
                    completion(Result.amountMismatch312)
                default:
                    completion(Result.failure(response.error!))
                }
        }
    }
    
    func completeCashCollection(with amount: Double, note: String, time: String, name: String, phoneNumber: String, email: String, method: Bool, singleItems: [String:Int], multiItems: [String:Int], deviceToken: String, ios: Int,completion: @escaping (Result) -> Void) {
        let url = baseURL.appendingPathComponent("charge")
        
        var deals = [String]()
        var choices = [String]()
        
        
        for (deal) in BasketArrays.deals {
            deals.append(deal.name!)
            for(choice) in deal.choices! {
                choices.append(deal.name! + " : " + choice)
            }
        }
        
        let params: [String: Any] = [
            "amount": amount,
            "currency": Constants.defaultCurrency,
            "description": Constants.defaultDescription,
            "note": note,
            "delivery": "Collection",
            "time": time,
            "name": name,
            "phoneNumber": phoneNumber,
            "email":email,
            "singleItems": BasketArrays.singleItems,
            "multiItems": BasketArrays.multiItems,
            "deals": deals,
            "choices": choices,
            "card": method,
            "deviceToken":deviceToken,
            "ios":ios
        ]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.response!.statusCode {
                case 201:
                    completion(Result.successChargeDelivery201)
                case 202:
                    completion(Result.successChargeCollection202)
                case 203:
                    completion(Result.successCashDelivery203)
                case 204:
                    completion(Result.successCashCollection204)
                case 306:
                    completion(Result.badRequestException306)
                case 307:
                    completion(Result.unauthorised307)
                case 308:
                    completion(Result.invalidRequest308)
                case 309:
                    completion(Result.notFound309)
                case 310:
                    completion(Result.cardError310)
                case 311:
                    completion(Result.serverError311)
                case 312:
                    completion(Result.amountMismatch312)
                default:
                    completion(Result.failure(response.error!))
                }
        }
    }
}


