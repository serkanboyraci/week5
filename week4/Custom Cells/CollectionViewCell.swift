//
//  CollectionViewCell.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 11.01.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }

}
