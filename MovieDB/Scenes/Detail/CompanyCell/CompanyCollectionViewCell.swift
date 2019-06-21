//
//  CompanyCollectionViewCell.swift
//  Project2
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Kingfisher

final class CompanyCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var companyImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: Methods
    func bindViewModel(_ model: CompanyViewModel) {
        companyImageView.kf.setImage(with: URL(string: API.Urls.profileUrl + model.logoPath),
                                     placeholder: UIImage(named: "movie"))
        nameLabel.text = model.name
    }
}
