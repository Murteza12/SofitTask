//
//  ResponseHandler.swift
//  Delivery_App
//
//   Created by Murteza on 10/10/2022.



import Foundation
import Alamofire
// MARK: - APIErrors
struct APIErrors: Codable, CodableInit {
    let success: Bool?
    let message: String?
}
struct CustomError: APIErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    private var _description: String
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
protocol APIErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}
protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ response: AFDataResponse<Data>, completion: CallResponse<T>)
}
extension HandleAlamoResponse {
    func handleResponse<T: CodableInit>(_ response: AFDataResponse<Data>, completion: CallResponse<T>) {
        if let error = response.error {
            print(error)
            ActivityIndicator.shared.hideLoadingIndicator()
            if let underlyingError = error.underlyingError {
                if let urlError = underlyingError as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        print("Timed out error")
//                        Utility.showLoaf(message: "Please try again later!", state: .warning, location: .top)
                        ActivityIndicator.shared.hideLoadingIndicator()
                        return
                    case .notConnectedToInternet:
                        print("Not connected")
//                        Utility.showLoaf(message: "Please make sure you are connected to Internet!", state: .error, location: .top)
                        ActivityIndicator.shared.hideLoadingIndicator()
                        return
                    default:
                        //Do something
                        print("Unmanaged error")
                    }
                }
            }
            print(error)
            if let data = response.data {
                do {
                    let tempData = try JSONDecoder().decode(APIErrors.self, from: data)
                    print(tempData.message ?? "")
                    var errorString = ""
                    errorString = tempData.message ?? ""
                    let customError = CustomError(title: "Deleted sucessfully!", description: errorString, code: error.responseCode ?? 204)
                    completion?(.failure(customError))
                }catch let err{
                    print(err)
                    if let err = err as? URLError, err.code  == URLError.Code.notConnectedToInternet {
//                       Utility.showLoaf(message: "Not Internet Connection",               state: .warning, location: .bottom)
                        print("Not Internet Connection")
                    } else {
                        // Other errors
                    }
                    completion?(.failure(error))
                }
            }
            return
        }
        switch response.result {
        case .failure(let error):
            completion?(.failure(error))
        case .success(let value):
            do {
                let modules = try T(data: value)
                completion?(.success(modules))
            } catch {
                completion?(.failure(error))
            }
        }
    }
}
