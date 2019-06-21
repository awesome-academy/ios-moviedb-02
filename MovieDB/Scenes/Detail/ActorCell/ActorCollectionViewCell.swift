//
//  ActorCollectionViewCell.swift
//  Project2
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Kingfisher

final class ActorCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var characterLabel: UILabel!
    
    // MARK: - Methods
    func bindViewModel(_ model: ActorViewModel) {
        avatarImageView.kf.setImage(with: URL(string: API.Urls.profileUrl + model.profilePath),
                                    placeholder: UIImage(named: "avatar"))
        nameLabel.text = model.name
        characterLabel.text = model.character
    }
}
