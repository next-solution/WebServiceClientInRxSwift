//
//  ApiClient.swift
//  WebServiceClientInRxSwift
//
//  Created by Marcin Makurat on 13/09/2020.
//  Copyright © 2020 Marcin Makurat. All rights reserved.
//

import Foundation

enum Api {}

extension Api {
    static func getCustomer() -> Endpoint<Customer> {
        return Endpoint(path: "customer/profile")
    }

    static func getCategories() -> Endpoint<Customer> {
        print("getting Categories")
        return Endpoint(
            method: .get,
            path: "customer/profile")
    }
    
    static func patchCustomer(firstName: String, lastName: String) -> Endpoint<Customer> {
        return Endpoint(
            method: .patch,
            path: "customer/profile",
            parameters: ["firstName" : firstName,
                         "lastName" : lastName]
        )
    }
}


//TODO Modify this
final class Customer: Decodable {
    let name: String
}
