//
//  GenreCollectionViewCell.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Kingfisher

final class GenreCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.red : UIColor.groupTableViewBackground
        }
    }
    
    func bindViewModel( _ viewModel: GenreModel) {
        backgroundColor = isSelected ? UIColor.red : UIColor.groupTableViewBackground
        nameLabel.text = viewModel.name
    }
}
