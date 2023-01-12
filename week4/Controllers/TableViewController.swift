//
//  TableViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    /*private var departments: [Department] = [
        .init(name: "IT",
              users: [
                .init(name: "Esra", id: "1"),
                .init(name: "Serkan", id: "2"),
                .init(name: "Kerem", id: "3"),
              ]
             ),
        .init(name: "HR",
              users: [
                .init(name: "Busra", id: "1"),
                .init(name: "Ayla", id: "2"),
                .init(name: "Memo", id: "3"),
              ]
             )
    ]*/
    
    private var coins: [CoinCellModel] = []
    private var filteredCoins : [CoinCellModel] = [] // to filer by search bar and show that data
    //private var users: [User] = [] // in normal app, we have empty array and we take data lately
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none // to delete seperator between cells
        
        tableView.register(.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCellIdentifier")// we decide identifier name.
        
        searchBar.delegate = self
     
        /*DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { // taking data and waiting
            self.users = [
                .init(name: "Mucahit", id: "01"),
                .init(name: "Serkan", id: "02" ),
                .init(name: "Esra", id: "03")
                ]
            
            self.tableView.reloadData() // we must add this, to refresh data.
        }*/
      
        fetchData()
    }
    private func fetchData() {
        if let url = URL(string: "https://api.coingecko.com/api/v3/coins/list") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                  
                  DispatchQueue.main.async {
                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(.init(title: "OK", style: .default))
                    alert.addAction(.init(title: "Retry", style: .default, handler: { _ in
                      // TODO: navigate another screen
                    }))
                    self.present(alert, animated: true)
                  }
                  return
}
                if let data = data {
                  do {
                    let apiCoins = try
                    JSONDecoder().decode([Coin].self, from: data) // we use JSONDecoder object as a Array, we use square bracket for Coin
                    self.coins = apiCoins.map{ .init(name: $0.name ?? "") } // we transform coin type to coinCellModel type
                    
                    DispatchQueue.main.async { // we enter background thread,
                      // if we want to UICompenent such as tableView, we must call from mainthread
                      self.tableView.reloadData()
                    }
                  } catch {
                    print("Decoding Error") //
                  }
                }
            }
          task.resume() // we must use this, otherwise after a while code will not run.
          }
    }
}

extension TableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCoins = coins.filter{ ($0.name).contains(searchText) } // to filter by search bar and defined in filteredCoins
        tableView.reloadData() // you must add this code
        /*var tempCoins : [Coin] = []  //difficult long way
        for coin in coins {
            if (coin.name ?? "").contains(searchText) {
                tempCoins.append(coin)
            }
        }
        filteredCoins = tempCoins*/
    }
}

extension TableViewController: UITableViewDelegate {
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // you can select row.
    //    let coin = coins[indexPath.row]
    //    print("\(indexPath.row) - \(coin.name ?? "")") // print its index 0,1,2
    //}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // means automatically grows as cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // to give header height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // to give view for header
        let containerView = UIView()
        containerView.backgroundColor = .systemBlue
    
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false // we must do it false to use constraints.
        //label.text = departments[section].name
        label.font = .systemFont(ofSize: 20, weight: .bold)
        containerView.addSubview(label) // to add label in containerview
        
        // to give constraints
       // NSLayoutConstraint.init(item: <#T##Any#>, attribute: <#T##NSLayoutConstraint.Attribute#>, relatedBy: <#T##NSLayoutConstraint.Relation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>) //difficult way, we used SnapKit instead of this.
        // difficult way
        
        NSLayoutConstraint.activate([ //easy way
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView // we add label in the containerView
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCoins.count //to reach each departments section users count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! UserCell
        //let user : User = departments[indexPath.section].users[indexPath.row]
        //cell.userNameLabel.text = coins[indexPath.row].name // we can reach XIB usernameLabel
        cell.userNameLabel.text = coins[indexPath.row].name // to write only names.
        return cell
        
        /*let cell = UITableViewCell()
        
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.id + " - " + user.name
        */
        
        
        /*if indexPath.row % 2 == 1 {
            cell.textLabel!.text = "serkan"
        } else {
            cell.textLabel!.text = "boyraci"
        }*/
        
        //var content = cell.defaultContentConfiguration()
        //content.text = placeNameArray[indexPath.row]
        //cell.contentConfiguration  = content
        //return cell
    }
}

//struct User {
//    let name : String
//    let id : String
//}

//struct Department {
//struct    let name : String
//struct    let users : [User]
//struct}

struct CoinCellModel { // we take name fieald. because we will show it only.
    let name : String //we dont need othe symbol and id field in our TableView.
}
