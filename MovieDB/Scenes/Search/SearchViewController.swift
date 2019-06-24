//
//  SearchViewController.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

final class SearchViewController: UIViewController, BindableType {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var resultTableView: RefreshTableView!
    @IBOutlet private weak var genresCollectionView: UICollectionView!
    
    // MARK: - Properties
    typealias SearchResultsDataSource = RxTableViewSectionedAnimatedDataSource<ResultSearchSection>
    
    var viewModel: SearchViewModel!
    private var searchResultsDataSource: SearchResultsDataSource!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Search"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Methods
    func bindViewModel() {
        
        searchResultsDataSource = SearchResultsDataSource(configureCell: { _, tb, indexPath, item in
            let cell: MovieTableViewCell = tb.dequeueReusableCell(for: indexPath)
            cell.bindViewModel(item)
            return cell
        })
        
        let selectionGenres = genresCollectionView.rx.itemSelected
            .asDriver()
            .startWith(IndexPath(row: 0, section: 0))
        let input = SearchViewModel.Input(loadTrigger: Driver.just(()),
                                          loadMoreTrigger: resultTableView.loadMoreBottomTrigger,
                                          refreshTrigger: resultTableView.loadMoreTopTrigger,
                                          selectionGenre: selectionGenres,
                                          textSearch: searchBar.rx.text.orEmpty.asDriver(),
                                          selectionMovie: resultTableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: rx.disposeBag)
        output.loading
            .drive()
            .disposed(by: rx.disposeBag)
        output.loadingMore
            .drive(resultTableView.loadingMoreBottom)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(resultTableView.loadingMoreTop)
            .disposed(by: rx.disposeBag)
        output.movieResult
            .drive(resultTableView.rx.items(dataSource: searchResultsDataSource))
            .disposed(by: rx.disposeBag)
        output.clearTextInSearchBar
            .drive(searchBar.rx.clearText)
            .disposed(by: rx.disposeBag)
        output.clearSelectedGenre
            .drive(genresCollectionView.rx.deSelectCell)
            .disposed(by: rx.disposeBag)
        output.genresList
            .drive(genresCollectionView.rx.items) { collectionView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: GenreCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.bindViewModel(element)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.gotoTop
            .map { CGPoint(x: 0, y: 0) }
            .drive(resultTableView.rx.contentOffset)
            .disposed(by: rx.disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyData
            .drive(resultTableView.isEmptyData)
            .disposed(by: rx.disposeBag)
    }
    
    private func configView() {
        hideKeyboardWhenTappedAround()
        configTableAndCollectionView()
        searchBar.delegate = self
    }
    
    private func configTableAndCollectionView() {
        resultTableView.do {
            $0.register(cellType: MovieTableViewCell.self)
            $0.estimatedRowHeight = 155
            $0.delegate = self
        }
        genresCollectionView.register(cellType: GenreCollectionViewCell.self)
        if let flowLayout = genresCollectionView.collectionViewLayout
            as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 150, height: 30)
        }
    }
    
}

// MARK: - StoryboardSceneBased
extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
