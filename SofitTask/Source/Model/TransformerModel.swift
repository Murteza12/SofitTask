//
//  TransformerModel.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import Foundation
// MARK: - ListTranformerResponse
struct ListTranformerResponse: Codable, CodableInit {
    let transformers: [Transformer]?
}

// MARK: - Transformer
struct Transformer: Codable {
    let id: String
    let name: String
    let team: String
    let teamIcon: String
    let courage, endurance, firepower: Int
    let intelligence: Int
    let rank, skill, speed, strength: Int
   
  

    enum CodingKeys: String, CodingKey {
        case courage, endurance, firepower, id, intelligence, name, rank, skill, speed, strength, team
        case teamIcon = "team_icon"
    }
}

// MARK: - DeleteTranformerResponse
struct DeleteTranformerResponse: Codable, CodableInit {
    let success: String?
}




// MARK: - Post Transformer
struct PostTransformer: Codable {
    let courage, endurance, firepower: Int
    let intelligence: Int
    let name: String
    let rank, skill, speed, strength: Int
    let team: String
    let teamIcon: String
}


// MARK: - Rating Model

struct TransformerRating: Codable {
    var name: String
    var team: String
    var id: String
    var rating : Int
    
    internal init(name: String,team: String, id: String, rating: Int) {
        self.name = name
        self.team = team
        self.id = id
        self.rating = rating
    }
}
