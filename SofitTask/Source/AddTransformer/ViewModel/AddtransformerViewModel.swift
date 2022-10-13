//
//  AddtransformerViewModel.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import Foundation
import Alamofire
protocol AddtransformerViewModelDelegate {
    func updated(message: String)
    func didReceiveError(message:String)
    func didReceiveValidationError(message:String)
}

class AddtransformerViewModel {
    var delegate:AddtransformerViewModelDelegate!
    
    var id : String = ""
    var name : String = ""
    var team : String = ""
    var strength : Int = 0
    var intelligence : Int = 0
    var speed : Int = 0
    var endurance : Int = 0
    var rank : Int = 0
    var courage : Int = 0
    var firepower : Int = 0
    var skill : Int = 0
    
    func isValidData() -> Bool {
        if name.isEmpty {
            delegate.didReceiveValidationError(message: "Name is required!")
            return false
        }
        
        if team.isEmpty {
            delegate.didReceiveValidationError(message: "Team is required!")
            return false
        }
        
        if self.strength == 0 {
            delegate.didReceiveValidationError(message: "Strength is required  & shound be 1- 10!")
            return false
        }
        
        if self.intelligence == 0 {
            delegate.didReceiveValidationError(message: "Intelligence is required  & shound be 1- 10!")
            return false
        }
        
        if self.speed == 0 {
            delegate.didReceiveValidationError(message: "Speed is required & shound be 1- 10!")
            return false
        }
        
        if self.endurance == 0 {
            delegate.didReceiveValidationError(message: "Endurance is required  & shound be 1- 10!")
            return false
        }
        
        if self.rank == 0 {
            delegate.didReceiveValidationError(message: "Rank is required  & shound be 1- 10!")
            return false
        }
        
        if self.courage == 0 {
            delegate.didReceiveValidationError(message: "Courage is required  & shound be 1- 10!")
            return false
        }
        
        if self.firepower == 0 {
            delegate.didReceiveValidationError(message: "Firepower is required  & shound be 1- 10!")
            return false
        }
        
        if self.skill == 0 {
            delegate.didReceiveValidationError(message: "Skill is required  & shound be 1- 10!")
            return false
        }
        
        return true
    }
    
    // MARK: - Add Tranformer
    func callAddTransformer() {
        let params : [String: Any] = [
            "name": self.name,
            "strength": self.strength,
            "intelligence": self.intelligence,
            "speed": self.speed,
            "endurance": self.endurance,
            "rank": self.rank,
            "courage": self.courage,
            "firepower": self.firepower,
            "skill": self.skill,
            "team": self.team
        ]
        
        let header:HTTPHeaders =
        [
            "Authorization": "Bearer \(Constant.ACCESS_TOKEN)",
            "Content-Type":"application/json"
        ]
        print(params)
        
        ActivityIndicator.shared.showLoadingIndicator()
        AF.request(Constant.BASE_URL + "transformers", method:.post, parameters: params,encoding: JSONEncoding.prettyPrinted,headers: header) .responseString { (response) in
            ActivityIndicator.shared.hideLoadingIndicator()
            print(response)
            if let jsonData = response.data {
                let result = try! JSONDecoder().decode(Transformer.self, from: jsonData)
                print(result)
                if result.id != "" {
                    self.delegate.updated(message: "Transformer Created!")
                }
            }
        }
        
    }
    
    
    // MARK: -  update Transformer
    func callUpdateTransformer() {
        let params : [String: Any] = [
            "id": self.id,
            "name": self.name,
            "strength": self.strength,
            "intelligence": self.intelligence,
            "speed": self.speed,
            "endurance": self.endurance,
            "rank": self.rank,
            "courage": self.courage,
            "firepower": self.firepower,
            "skill": self.skill,
            "team": self.team
        ]
        
        let header:HTTPHeaders =
        [
            "Authorization": "Bearer \(Constant.ACCESS_TOKEN)",
            "Content-Type":"application/json"
        ]
        print(params)
        
        ActivityIndicator.shared.showLoadingIndicator()
        AF.request(Constant.BASE_URL + "transformers", method:.put, parameters: params,encoding: JSONEncoding.prettyPrinted,headers: header) .responseString { (response) in
            ActivityIndicator.shared.hideLoadingIndicator()
            print(response)
            if let jsonData = response.data {
                let result = try! JSONDecoder().decode(Transformer.self, from: jsonData)
                print(result)
                if result.id != "" {
                    self.delegate.updated(message: "Transformer updated!")
                }
            }
        }
    }
}

enum edtingType {
    case add
    case edit
}


