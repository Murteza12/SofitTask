//
//  DefaultResponse.swift
//  Delivery_App
//
//  Created by Murteza on 10/10/2022.


import Foundation

/// Default response to check for every request since this's how this api works.
struct DefaultResponse: Codable, CodableInit {
    var status: Int
}

