//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

import Kingfisher
import Cosmos

final class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingView: CosmosView!
    
    private var movie: Movie!
    
    func bindViewModel(_ movieModel: MovieModelType) {
        posterImageView.kf.setImage(with: URL(string: API.Urls.posterUrl + movieModel.posterPath))
        titleLabel.text = movieModel.title
        releaseDateLabel.text = movieModel.releaseDate
        overViewLabel.text = movieModel.overview
        ratingView.rating = movieModel.voteAverage
        genresLabel.text = movieModel.genres
    }
}
