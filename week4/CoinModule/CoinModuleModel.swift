//
//  CoinModuleModel.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 16.01.2023.
//

import Foundation
import Alamofire

protocol CoinModuleModelDelegate: AnyObject { // to inform ViewModel.
    // to use weak var delegate, we use AnyObject(to use class and structs)
    func didDataFetch()
    func didDataCouldntFetch()
}


class CoinModuleModel {
    
    private(set) var coins: [Coin] = []
    
    weak var delegate: CoinModuleModelDelegate?
    
    func fetchData() {
        AF.request("https://api.coingecko.com/api/v3/coins/list").responseDecodable(of: [Coin].self)
        {[weak self] (res) in
            guard
                let apiCoins = res.value
            else {
                self?.delegate?.didDataCouldntFetch()
                return
                
            } // value = [Coin]
            self?.coins = apiCoins//.map{ .init(from: $0.xxxx ?? "") } // we transform coin type to coinCellModel type //no need to write mainthread. alamofir do it main thread.
          
            self?.delegate?.didDataFetch()

        }
    }
}
