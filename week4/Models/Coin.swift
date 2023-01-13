//
//  Coin.swift
//  week4
//
//  Created by Ali serkan Boyracı  on 31.12.2022.
//

import Foundation

struct Coin : Decodable {
    let id, symbol, xxxx: String?
    
    enum CodingKeys: String, CodingKey {
    case id, symbol
    case xxxx = "name"
    }
}

