//
//  DetailViewController.swift
//  Project2
//
//  Created by cuonghx on 6/15/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import YoutubeKit
import WebKit
import Cosmos
import RxDataSources

final class DetailViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var ytBaseView: UIView!
    @IBOutlet private weak var actorCollectionView: UICollectionView!
    @IBOutlet private weak var companyCollectionView: UICollectionView!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var starRateView: CosmosView!
    
    // MARK: - Properties
    typealias ActorDataSource = RxCollectionViewSectionedReloadDataSource<ActorSection>
    typealias CompanyDataSource = RxCollectionViewSectionedReloadDataSource<CompanySection>
    
    private var actorDataSource: ActorDataSource!
    private var companyDataSource: CompanyDataSource!
    private var player: YTSwiftyPlayer!
    var viewModel: DetailViewModel!
    private var favoriteBarButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "unfavorite"),
                               style: .plain,
                               target: nil,
                               action: nil)
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configYTSwiftyPlayer()
        configCollectionView()
    }
    
    deinit {
        logDeinit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = favoriteBarButton
    }
    
    // MARK: - Methods
    private func configYTSwiftyPlayer() {
        player = YTSwiftyPlayer(frame: ytBaseView.frame,
                                playerVars: [])
        ytBaseView.addSubview(player)
    }
    
    private func configCollectionView() {
        actorCollectionView.register(cellType: ActorCollectionViewCell.self)
        companyCollectionView.register(cellType: CompanyCollectionViewCell.self)
        guard let flowLayoutActor =
            actorCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let flowLayoutCompany =
            companyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
        }
        flowLayoutActor.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        flowLayoutCompany.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    
    func bindViewModel() {
        actorDataSource =
            ActorDataSource(configureCell: { ( _, collectionView, indexPath, model ) in
                let item: ActorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                item.bindViewModel(model)
                return item
            })
        companyDataSource =
            CompanyDataSource(configureCell: { ( _, collectionView, indexPath, model ) in
                let item: CompanyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                item.bindViewModel(model)
                return item
            })
        
        let input = DetailViewModel.Input(loadTrigger: Driver.just(()))
        
        let output = viewModel.transform(input)
        
        output.movie
            .drive(movieModel)
            .disposed(by: rx.disposeBag)
        output.trailerLink
            .drive(player.rx.settingVideo)
            .disposed(by: rx.disposeBag)
        output.actorList
            .drive(actorCollectionView.rx.items(dataSource: actorDataSource))
            .disposed(by: rx.disposeBag)
        output.companyList
            .drive(companyCollectionView.rx.items(dataSource: companyDataSource))
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loadingTrailer
            .drive(ytBaseView.isLoading)
            .disposed(by: rx.disposeBag)
    }
}

extension DetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.detail
}

extension DetailViewController {
    var movieModel: Binder<Movie> {
        return Binder(self) { vc, movie in
            vc.nameLabel.text = movie.title
            vc.overViewLabel.text = movie.overview
            vc.releaseDateLabel.text = movie.releaseDate
            vc.title = movie.title
            vc.starRateView.rating = movie.voteAverage
        }
    }
}
