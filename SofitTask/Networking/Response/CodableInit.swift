//
//  CodableInit.swift
//  Delivery_App
//
//  Created by Murteza on 10/10/2022.


import Foundation

protocol CodableInit: Codable {
    init(data: Data) throws
}

extension CodableInit  {
    init(data: Data) throws {
        let decoder = JSONDecoder()

        self = try decoder.decode(Self.self, from: data)
    }
}


