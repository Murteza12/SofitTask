//
//  HomeTransferViewController.swift
//  SofitTask
//
//  Created by Murteza on 12/10/2022.
//

import UIKit

class HomeTransferViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var battleLabel: UILabel!
    @IBOutlet weak var winningLabel: UILabel!
    @IBOutlet weak var survivoreLabel: UILabel!
    
    // MARK: - variable
    private lazy var viewModel:HomeTransformerViewModel = {
        let vm = HomeTransformerViewModel()
        vm.delegate = self
        return vm
    }()
    var ratingArray : [TransformerRating] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUp()
        if Connectivity.isConnectedToInternet {
            viewModel.callgetTranformerApi()
        } else {
            print(Constant.CONNECTION_ERROR)
        }
    }
    
    func setUp(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TranforamerTableViewCell.nib, forCellReuseIdentifier: TranforamerTableViewCell.identifier)
    }
    
    @IBAction private func addAction(_ sender: UIButton) {
        let vc = AddTransformerViewController.instantiateMain()
        vc.type = .add
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateResult() {
        if viewModel.defaultArray.count > 0 {
            for value in viewModel.defaultArray {
                let ratingSum = value.strength + value.intelligence + value.speed + value.endurance + value.rank + value.courage + value.firepower + value.skill
                let ratingObject = TransformerRating(name: value.name, team: value.team, id: value.id, rating: ratingSum)
                
                self.ratingArray.append(ratingObject)
            }
            
            let highestRating = ratingArray.max { $0.rating < $1.rating }
            let lowestRating = ratingArray.min { $0.rating < $1.rating }
            
            self.battleLabel.text = "1 battle"
            self.winningLabel.text = "Winning team (\(highestRating?.team ?? "")): \(highestRating?.name ?? "")"
            self.survivoreLabel.text = "Survivors from the losing team (\(lowestRating?.team ?? "")): \(lowestRating?.name ?? "")"
        }
    }
    
    @IBAction private func resultAction(_ sender: UIButton) {
        self.updateResult()
        
    }
    
}

// MARK: - TableviewDelegate
extension HomeTransferViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transformerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TranforamerTableViewCell.identifier, for: indexPath) as! TranforamerTableViewCell
        
        cell.item = viewModel.transformerArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Edit or Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            //Code I want to do here
            AppAlert.shared.simpleAlert(view: self, title: "Delete", message: "Do you want delete transformer?", buttonOneTitle: "Cancel", buttonTwoTitle: "OK")
            AppAlert.shared.onTapAction = { [weak self] tag in
                guard let self = self else {
                    return
                }
                if tag == 0 {
                    // DO YOUR WORK
                } else if tag == 1 {
                    // DO YOUR WORK
                    print("delete")
                    let id  = self.self.viewModel.transformerArray[indexPath.row].id
                    self.viewModel.callDeleteTranformerApi(id: id)
                }
            }
            
            
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            print("Edit")
            let vc = AddTransformerViewController.instantiateMain()
            vc.type = .edit
            vc.transformer = self.viewModel.transformerArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
        return swipeActions
    }
}

// MARK: - ViewModel Delegate
extension HomeTransferViewController: HomeTransformerViewModelDelegate {
    func updateView() {
        self.tableView.reloadData()
        self.updateResult()
    }
    
    func didReceiveError(message: String) {
        print(message)
    }
    
}
