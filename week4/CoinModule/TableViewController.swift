//
//  TableViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    @IBOutlet private weak var loadingView: UIView!
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    private var coins: [CoinCellModel] = []
    private let viewModel = CoinModuleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.viewDidLoad() // to inform uploaded.
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none // to delete seperator between cells
        tableView.register(.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCellIdentifier")// we decide identifier name.
        searchBar.delegate = self
    }
    
    private func setupBindings() {
        viewModel.isLoadingIndicatorShowing = { [weak self] isShowing in
            self?.loadingView.isHidden = !isShowing
            self?.indicator.isHidden = !isShowing
            isShowing ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
        }
        
        viewModel.showData = { [weak self] coins in
            self?.coins = coins
            self?.tableView.reloadData()
        }
        
        viewModel.showAlert = { [weak self] message in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension TableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText) // to order ViewModel to search
    }
}

extension TableViewController: UITableViewDelegate {
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count //to reach each departments section users count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! UserCell
        //let user : User = departments[indexPath.section].users[indexPath.row]
        //cell.userNameLabel.text = coins[indexPath.row].name // we can reach XIB usernameLabel
        cell.userNameLabel.text = coins[indexPath.row].name // to write only names.
        return cell
    }
}
        

struct CoinCellModel { // we take name fieald. because we will show it only.
    let name : String //we dont need othe symbol and id field in our TableView.
}
