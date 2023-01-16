//
//  CoinModuleViewModel.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 16.01.2023.
//

import Foundation

class CoinModuleViewModel {
    
    private var model = CoinModuleModel()
    
    var showData: (([CoinCellModel]) -> ())?
    var showAlert: ((String) -> ())?
    var isLoadingIndicatorShowing: ((Bool) -> ())?
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad() { // to inform ViewModel to view uploaded.
        isLoadingIndicatorShowing?(true)
        model.fetchData() // taking data but, not known what is done. we must inform it.
    }
    
    func search(with text: String?)  {
        guard
            let text = text,
              text.count > 0 //not null string
        else {
            showData?([]) // show empty string.
            return
        }
        // to show searched coins
        var cellModels: [CoinCellModel] = [] //define bottom of the view
        cellModels = model.coins
            .filter{ ($0.name ?? "").contains(text) }
            .map{.init(name: $0.name ?? "")} // to transform type of CoinCellModel
        showData?(cellModels)
    }   
}

extension CoinModuleViewModel: CoinModuleModelDelegate {
    func didDataFetch() {
        isLoadingIndicatorShowing?(false)
        var cellModels: [CoinCellModel] = [] //define bottom of the view
        cellModels = model.coins.map{ .init(name: $0.name ?? "")}
        showData?(cellModels)
    }
    
    func didDataCouldntFetch() {
        isLoadingIndicatorShowing?(false)
        showAlert?("Some Problems Occured.Pleasetry again later.")
    }
}
