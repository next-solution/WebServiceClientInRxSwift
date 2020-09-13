//
//  Client.swift
//  WebServiceClientInRxSwift
//
//  Created by Marcin Makurat on 13/09/2020.
//  Copyright © 2020 Marcin Makurat. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import OAuthSwift
import CryptoKit


protocol ClientProtocol {
//    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

final class Client: ClientProtocol {
//    private let manager: Alamofire.Session
    private let baseURL = URL(string: "https://allegro.pl.allegrosandbox.pl")!
    private let queue = DispatchQueue(label: "queue")

    init() {
//        var defaultHeaders = Alamofire.HTTPHeaders.default
//        defaultHeaders["Authorization"] = "Bearer \(accessToken)"

        let configuration = URLSessionConfiguration.default

        // Add `Auth` header to the default HTTP headers set by `Alamofire`
//        configuration.headers = defaultHeaders
        
        let oauthswift = OAuth2Swift(
            consumerKey:    "95f28e9aa1d14c61b6065d0f9f58b0b6",
            consumerSecret: "gyENdf25WXROQfJGRovpXTSTjRdWA0IYnW18lfTaZ31aGP0HCr7oRDQaozuVh3J3",
            authorizeUrl:   "https://allegro.pl.allegrosandbox.pl/auth/oauth/authorize",
            responseType: "code"
        )
        oauthswift.accessTokenBasicAuthentification = true

        let codeVerifier = "2837sdhhdksjahdsadgsahjdgsajhgdjhsadshabdhjsabdhjsadhasdhbskhjkhjhjkhjhjhjahbdshja"
        let inputData = Data(codeVerifier.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
//        let handler = oauthswift.authorize(
//            withCallbackURL: "https://callback/",
//            scope: "requestedScope",
//            state:"State01",
//            codeChallenge: hashString.toBase64URL(),
//            codeChallengeMethod: "S256",
//            codeVerifier: codeVerifier) { result in
//            switch result {
//            case .success(let (credential, response, parameters)):
//              print(credential.oauthToken)
//              // Do your request
//            case .failure(let error):
//              print(error.localizedDescription)
//            }
//        }
        
        let handle = oauthswift.authorize(
            withCallbackURL: "https://callback/",
            scope: "", state:"") { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print(credential.oauthToken)
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
        
        oauthswift.client.get("https://api.allegro.pl.allegrosandbox.pl/customer/profile") { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        
//        self.manager = Alamofire.Session.init(configuration: configuration, interceptor: OAuthSwift2RequestInterceptor(oauthswift))

    }
    

//    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
//        return Single<Response>.create { observer in
//            let path = self.url(path: endpoint.path).string
//            let request = self.manager.request(
//                path,
//                method: httpMethod(from: endpoint.method),
//                parameters: endpoint.parameters
//            )
//            request
//                .validate()
//                .responseData(queue: self.queue) { response in
//                    do {
//                        let result = try response.data.flatMap(endpoint.decode)
//                        switch result {
//                        case let .some(val): observer(.success(val))
//                        case .none: observer(.error(RxError.noElements))
//                        }
//                    } catch {
//                        print("request problem")
//                    }
//
//            }
//            return Disposables.create {
//                request.cancel()
//            }
//        }
//    }
//
//    private func url(path: Path) -> URL {
//        return baseURL.appendingPathComponent(path)
//    }
}

private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
    switch method {
    case .get: return .get
    case .post: return .post
    case .put: return .put
    case .patch: return .patch
    case .delete: return .delete
    }
    
    
}

extension String {
    
    func fromBase64URL() -> String? {
        var base64 = self
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 = base64.appending("=")
        }
        guard let data = Data(base64Encoded: base64) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64URL() -> String {
        var result = Data(self.utf8).base64EncodedString()
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
}

