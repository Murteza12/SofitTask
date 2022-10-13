//
//  AddTransformerViewController.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import UIKit

class AddTransformerViewController: UIViewController {
    
    // MARK: - IBOUTlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var strengthField: UITextField!
    @IBOutlet weak var intelligenceField: UITextField!
    @IBOutlet weak var speedField: UITextField!
    @IBOutlet weak var enduranceField: UITextField!
    @IBOutlet weak var rankField: UITextField!
    @IBOutlet weak var courageField: UITextField!
    @IBOutlet weak var firepowerField: UITextField!
    @IBOutlet weak var skillField: UITextField!
    @IBOutlet weak var teamField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Variable
    var type: edtingType!
    var transformer : Transformer?
    
    // MARK: - variable
    private lazy var viewModel: AddtransformerViewModel = {
        let vm = AddtransformerViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        
    }
    
    func setupUI() {
        switch self.type {
        case .add:
            self.title = "Add Transformer"
            self.addButton.setTitle("Add", for: .normal)
        case .edit:
            self.title = "Update Transformer"
            self.addButton.setTitle("Update", for: .normal)
            self.LoadValues()
        case .none:
            self.title = "Add Transformer"
        }
    }
    
    func LoadValues() {
        self.nameField.text = self.transformer?.name
        self.teamField.text = self.transformer?.team
        self.strengthField.text = "\(self.transformer?.strength ?? 0)"
        self.intelligenceField.text = "\(self.transformer?.intelligence ?? 0)"
        self.speedField.text = "\(self.transformer?.speed ?? 0)"
        self.enduranceField.text = "\(self.transformer?.endurance ?? 0)"
        self.rankField.text = "\(self.transformer?.rank ?? 0)"
        self.courageField.text = "\(self.transformer?.courage ?? 0)"
        self.firepowerField.text = "\(self.transformer?.firepower ?? 0)"
        self.skillField.text = "\(self.transformer?.skill ?? 0)"
    }
    
    
    func updateViewModelFromFields() {
        
        if let name = nameField.text as NSString?, name.length > 0 {
            viewModel.name = name as String
        }
        
        if let team = teamField.text as NSString?, team.length > 0 {
            viewModel.team = team as String
        }
        
        if let strength = strengthField.text as NSString?, strength.length > 0 {
            viewModel.strength = (strength).integerValue
        }
        if let intellegence = intelligenceField.text as NSString?, intellegence.length > 0 {
            viewModel.intelligence = (intellegence).integerValue
        }
        
        if let speed = speedField.text as NSString?, speed.length > 0 {
            viewModel.speed = (speed).integerValue
        }
        if let endurance = enduranceField.text as NSString?, endurance.length > 0 {
            viewModel.endurance = (endurance).integerValue
        }
        if let rank = rankField.text as NSString?, rank.length > 0 {
            viewModel.rank = (rank).integerValue
        }
        
        if let courage = courageField.text as NSString?, courage.length > 0 {
            viewModel.courage = (courage).integerValue
        }
        
        if let firepower = firepowerField.text as NSString?, firepower.length > 0 {
            viewModel.firepower = (firepower).integerValue
        }
        
        if let skill = skillField.text as NSString?, skill.length > 0 {
            viewModel.skill = (skill).integerValue
        }
        
    }
    
    @IBAction private func AddAction(_ sender: UIButton) {
        self.updateViewModelFromFields()
        if Connectivity.isConnectedToInternet {
            switch self.type {
                
            case .edit:
                viewModel.id = self.transformer!.id
                viewModel.callUpdateTransformer()
            default:
                viewModel.callAddTransformer()
            }
        } else {
            AppAlert.shared.simpleAlert(view: self, title: "Connection", message: Constant.CONNECTION_ERROR, buttonTitle: "OK")
        }
    }
    
}


// MARK: - ViewModel Delegate

extension AddTransformerViewController: AddtransformerViewModelDelegate {
    func updated(message: String) {
        print("updated")
        AppAlert.shared.simpleAlert(view: self, title: "Success", message: message, buttonTitle: "OK")
    }
    
    func didReceiveError(message: String) {
        AppAlert.shared.simpleAlert(view: self, title: "Error", message: message, buttonTitle: "OK")
    }
    
    func didReceiveValidationError(message: String) {
        AppAlert.shared.simpleAlert(view: self, title: "Error", message: message, buttonTitle: "OK")
    }
    
    
}

