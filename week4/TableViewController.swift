//
//  TableViewController.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 29.12.2022.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var coins: [Coin] = []
    //private var users: [User] = [] // in normal app, we have empty array and we take data lately
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none // to delete seperator between cells
        
        tableView.register(.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCellIdentifier")// we decide identifier name.
     
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
                    let coins = try
                    JSONDecoder().decode([Coin].self, from: data) // we use JSONDecoder object as a Array, we use square bracket for Coin
                    self.coins = coins
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

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // you can select row.
        let coin = coins[indexPath.row]
        print("\(indexPath.row) - \(coin.name ?? "")") // print its index 0,1,2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellIdentifier", for: indexPath) as! UserCell
        
        cell.userNameLabel.text = coins[indexPath.row].name // we can reach XIB usernameLabel
        
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

struct User {
    let name : String
    let id : String
}
