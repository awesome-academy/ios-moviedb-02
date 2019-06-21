//
//  PopularViewModelTest.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

// swiftlint:disable force_try
final class PopularListViewModelTest: XCTestCase {
    
    private var viewModel: PopularListViewModel!
    private var usecase: PopularListUseCaseMock!
    private var navigator: PopularListNavigatorMock!
    
    private var input: PopularListViewModel.Input!
    private var output: PopularListViewModel.Output!
    
    private var disposeBag = DisposeBag()
    
    private let loadTrigger = PublishSubject<Void>()
    private let refreshTrigger = PublishSubject<Void>()
    private let loadMoreTrigger = PublishSubject<Void>()
    private let selection = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        navigator = PopularListNavigatorMock()
        usecase = PopularListUseCaseMock()
        viewModel = PopularListViewModel(navigator: navigator,
                                         usecase: usecase)
        input = PopularListViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                           refreshTrigger: refreshTrigger.asDriverOnErrorJustComplete(),
                                           loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
                                           selection: selection.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        output.error.drive().disposed(by: disposeBag)
        output.fetchItems.drive().disposed(by: disposeBag)
        output.isEmptyData.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.loadingMore.drive().disposed(by: disposeBag)
        output.movieList.drive().disposed(by: disposeBag)
        output.refreshing.drive().disposed(by: disposeBag)
        output.selectedItems.drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_getMoviesList() {
        let expectation = self.expectation(description: "expected getMoviesList() to be called")
        usecase.getMoviesListCalled = expectation
        
        // act
        loadTrigger.onNext(())
        let movies = try! output.movieList.toBlocking().first()
        
        XCTAssertEqual(movies?.first?.items.count, 1)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_loadTrigger_getMoviesList_failedShowError() {
        // arrange
        let getMovieListReturnValue = PublishSubject<PagingInfo<Movie>>()
        usecase.getMovieListReturnValue = getMovieListReturnValue
        
        // act
        loadTrigger.onNext(())
        getMovieListReturnValue.onError(TestError())
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(error is TestError)
    }
    
    func test_loadMoreTrigger_LoadMoreMovie() {
        let expectation = self.expectation(description: "expected loadMoreMovies() to be called")
        usecase.loadMoreMoviesCalled = expectation
        
        // act
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let movies = try! output.movieList.toBlocking().first()
        
        XCTAssertEqual(movies?.first?.items.count, 2)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_selectedMovieItem_showDetailMovie() {
        let expectation = self.expectation(description: "expected toDetailVC() to be called")
        navigator.expectationToDetailCalled = expectation
        
        //act
        loadTrigger.onNext(())
        selection.onNext(IndexPath(row: 0,
                                   section: 0))
        // Test
        waitForExpectations(timeout: 1, handler: nil)
    }
}
