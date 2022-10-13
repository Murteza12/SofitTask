//
//  HomeTransformerViewModel.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import Foundation

protocol HomeTransformerViewModelDelegate {
    func updateView()
    func didReceiveError(message:String)
}

class HomeTransformerViewModel {
    var delegate: HomeTransformerViewModelDelegate!
  
    var defaultArray : [Transformer] = []
    var transformerArray : [Transformer] = []{
        didSet{
            delegate.updateView()
        }
    }
    
 
    
    // MARK: - Get Tranformer Api
    func callgetTranformerApi() {
        ActivityIndicator.shared.showLoadingIndicator()
        MainRoutes.getTransFormer.send(ListTranformerResponse.self) { (results) in
            ActivityIndicator.shared.hideLoadingIndicator()
            switch results {
            case .failure(let error):
                print(error)
                self.delegate.didReceiveError(message: error.localizedDescription)
            case .success(let value ):
                print(value)
                if  !(value.transformers?.isEmpty ?? true){
                    self.defaultArray = value.transformers ?? []
                    self.transformerArray = value.transformers ?? []
                }else{
                    self.delegate.didReceiveError(message: "No data found!")
                }
                
            }
        }
    }
    
    
    // MARK: - Get Tranformer Api
    func callDeleteTranformerApi(id: String) {
        ActivityIndicator.shared.showLoadingIndicator()
        MainRoutes.deleteTransformer(id: id).send(DeleteTranformerResponse.self) { (results) in
            ActivityIndicator.shared.hideLoadingIndicator()
            switch results {
            case .failure(let error):
                print(error)
                self.delegate.didReceiveError(message: error.localizedDescription)
                self.callgetTranformerApi()
            case .success(let value ):
                print(value)
                self.callgetTranformerApi()
            }
        }
    }
    
    
}

