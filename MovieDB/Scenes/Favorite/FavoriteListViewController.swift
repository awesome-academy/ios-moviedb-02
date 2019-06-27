//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by cuonghx on 6/23/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

final class FavoriteListViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Propeties
    typealias FavoriteMovieDataSource = RxTableViewSectionedAnimatedDataSource<FavoriteMovieSection>
    
    var viewModel: FavoriteListViewModel!
    private var dataSource: FavoriteMovieDataSource!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Favorite"
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    private func configView() {
        tableView.do {
            $0.register(cellType: MovieTableViewCell.self)
            $0.estimatedRowHeight = 145
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        dataSource = FavoriteMovieDataSource(configureCell: { ( _, tableView, indexPath, movie ) in
                let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.bindViewModel(movie)
                return cell
            })
        
        dataSource.canEditRowAtIndexPath = { _, _ in true }
        
        let input = FavoriteListViewModel.Input(selection: tableView.rx.itemSelected.asDriver(),
                                                deletion: tableView.rx.itemDeleted.asDriver(),
                                                loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.movieList
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.deletedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension FavoriteListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
