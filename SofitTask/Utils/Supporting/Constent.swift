//
//  Constent.swift
//  TTDLAL(Cutomer)
//
//  Created by Murteza on 10/05/2021.
//

import Foundation
struct Constant {
static let BASE_URL = ""
    
    enum TransactionType {
        
        static let TRX_SRX_SEND = "send_money"
        static let TRX_SRX_TOPUP = "Stripe"
        static let TRX_SRX_LOAN = "loan_process_fee"
        static let TRX_SRX_INSURANCE_CAR = "Car_insurance_amount"
        static let TRX_SRX_INSURANCE_HOME = "Home_insurance_amount"
        static let TRX_SRX_INSURANCE_TRAVEL = "Travel_insurance_amount"
        static let TRX_SRX_INSURANCE_HEALTH = "Health_insurance_amount"
        static let TRX_SRX_INSURANCE_PHONE = "MobilePhone_insurance_amount"
        static let TRX_SRX_INSURANCE_PET = "Pet_insurance_amount"
        static let TRX_SRX_MARKETPLACE = "product_payment"
        static let TRX_SRX_SAVINGS = "_saving_deposit"
        static let TRX_SRX_RECHARGE = "recharge_payment"
        static let TRX_SRX_SAVING_WITHDRAW = "saving_withdraw"
        static let TRX_SRX_SAVING_DEPOSIT = "saving_deposit"
    }
    
}



