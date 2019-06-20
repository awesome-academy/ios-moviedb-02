//
//  UpcomingListViewController.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

final class UpcomingListViewController: UIViewController, BindableType {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: RefreshTableView!
    
    // MARK: - Properties
    typealias UpcomingDataSource = RxTableViewSectionedReloadDataSource<UpcomingMovieSection>
    
    var viewModel: UpcomingListViewModel!
    private var dataSource: UpcomingDataSource!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Upcoming"
    }
    
    // MARK: - Methods
    private func configView() {
        tableView.do {
            $0.register(cellType: MovieTableViewCell.self)
            $0.estimatedRowHeight = 156
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        dataSource = UpcomingDataSource(configureCell: { _, tableView, indexPath, item in
            let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.bindViewModel(item)
            return cell
        })
        
        let input = UpcomingListViewModel.Input(loadTrigger: Driver.just(()),
                                                refreshTrigger: tableView.loadMoreTopTrigger,
                                                loadMoreTrigger: tableView.loadMoreBottomTrigger)
        
        let output = viewModel.transform(input)
        
        output.movieList
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.loading
            .drive()
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(tableView.loadingMoreBottom)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(tableView.loadingMoreTop)
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive(tableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension UpcomingListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

// MARK: - UITableViewDelegate
extension UpcomingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
