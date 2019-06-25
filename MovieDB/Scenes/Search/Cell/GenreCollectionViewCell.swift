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
            backgroundColor = isSelected ? .red : .groupTableViewBackground
        }
    }
    
    func bindViewModel( _ viewModel: GenreModel) {
        backgroundColor = isSelected ? .red : .groupTableViewBackground
        nameLabel.text = viewModel.name
    }
}
