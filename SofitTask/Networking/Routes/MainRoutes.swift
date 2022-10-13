//
//  MainRoutes.swift
//  SofitTask
//
//  Created by Murteza on 10/10/2022.
//

import Foundation
import Alamofire
enum MainRoutes: URLRequestBuilder {
   
    case getTransFormer
    case postTransFormer(param: Parameters)
    case updateTransFormer(param: Parameters)
    case deleteTransformer(id: String)
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .getTransFormer:
            return "transformers"
        case .postTransFormer:
            return "transformers"
        case .updateTransFormer:
            return "transformers"
        case .deleteTransformer( let id):
            return "transformers/\(id)"
        }
    }
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        case .getTransFormer:
            return nil
        case .postTransFormer(let param):
            params = param
        case .updateTransFormer(let param):
            params = param
        case .deleteTransformer:
            return nil
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getTransFormer:
            return .get
        case .updateTransFormer:
            return .put
        case .deleteTransformer:
            return .delete
        default:
            return .post
        }
    }
    // MARK: - HTTPHeaders
    internal var headers: HTTPHeaders {
      
        let header:HTTPHeaders =
            [
                "Authorization": "Bearer \(Constant.ACCESS_TOKEN)",
                "Content-Type":"application/json"
            ]
        switch self {
         
        default:
            return header
        }
        
    }
}
