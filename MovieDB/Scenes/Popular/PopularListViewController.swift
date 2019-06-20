//
//  PopularViewController.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

final class PopularListViewController: UIViewController, BindableType {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: RefreshTableView!
    
    // MARK: - Propeties
    typealias PopularDataSource = RxTableViewSectionedReloadDataSource<PopularMovieSection>
    
    var viewModel: PopularListViewModel!
    private var dataSource: PopularDataSource!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        logDeinit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Popular"
    }
    
    // MARK: - Method
    private func setupView() {
        tableView.register(cellType: MovieTableViewCell.self)
        tableView.estimatedRowHeight = 156
        tableView.delegate = self
    }
    
    func bindViewModel() {
        dataSource = PopularDataSource(configureCell: { ( _, tableView, indexPath, model ) in
            let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.bindViewModel(model)
            return cell
        })
        
        let input = PopularListViewModel.Input(loadTrigger: Driver.just(()),
                                               refreshTrigger: tableView.loadMoreTopTrigger,
                                               loadMoreTrigger: tableView.loadMoreBottomTrigger,
                                               selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.movieList
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.loading
            .drive()
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(tableView.loadingMoreTop)
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(tableView.loadingMoreBottom)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.selectedItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

extension PopularListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

extension PopularListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
