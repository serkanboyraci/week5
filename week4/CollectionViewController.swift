//
//  CollectionViewController.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 11.01.2023.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var coins: [Coin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI() // use this like this, to use cleancode.
        fetchData()
    }
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell") //you must use this like tableView Cell
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
                            self.collectionView.reloadData()
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

extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // you can define each items size
        return .init(width: collectionView.frame.width/2, height: collectionView.frame.height/2)
    }
}

extension CollectionViewController : UICollectionViewDelegate {
    
}

extension CollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = coins[indexPath.row].name
        return cell
        
    }
}
