//
//  Internet+Extension.swift
//  fonewire
//
//  Created by Murteza on 13/08/2021.
//
import Alamofire
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
