//
//  SearchViewModelTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

// swiftlint:disable force_try
final class SearchViewModelTests: XCTestCase {
    
    private var usecase: SearchUseCaseMock!
    private var navigator: SearchNavigatorMock!
    private var viewModel: SearchViewModel!
    
    private var input: SearchViewModel.Input!
    private var output: SearchViewModel.Output!
    
    private let disposeBag = DisposeBag()
    
    private let loadTrigger = PublishSubject<Void>()
    private let loadMoreTrigger = PublishSubject<Void>()
    private let refreshTrigger = PublishSubject<Void>()
    private let selectionGenre = PublishSubject<[IndexPath]>()
    private let selectionMovie = PublishSubject<IndexPath>()
    private let textSearch = PublishSubject<String>()
    
    override func setUp() {
        super.setUp()
        usecase = SearchUseCaseMock()
        navigator = SearchNavigatorMock()
        viewModel = SearchViewModel(usecase: usecase,
                                    navigator: navigator)
        input = SearchViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                      loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete(),
                                      refreshTrigger: refreshTrigger.asDriverOnErrorJustComplete(),
                                      selectionGenre: selectionGenre.asDriverOnErrorJustComplete(),
                                      textSearch: textSearch.asDriverOnErrorJustComplete(),
                                      selectionMovie: selectionMovie.asDriverOnErrorJustComplete())
        output = viewModel.transform(input)
        
        output.error
            .drive()
            .disposed(by: disposeBag)
        output.fetchItems
            .drive()
            .disposed(by: disposeBag)
        output.genresList
            .drive()
            .disposed(by: disposeBag)
        output.loading
            .drive()
            .disposed(by: disposeBag)
        output.loadingMore
            .drive()
            .disposed(by: disposeBag)
        output.movieResult
            .drive()
            .disposed(by: disposeBag)
        output.refreshing
            .drive()
            .disposed(by: disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: disposeBag)
    }
    
    func test_loadTrigger_getMoviesList() {
        
        let expect = self.expectation(description: "expect searchMovie() to be called")
        usecase.getMovieListCalled = expect
        // act
        textSearch.onNext("")
        selectionGenre.onNext([])
        loadTrigger.onNext(())
        
        // expect
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_textChange_getMoviesList() {
        let expect = self.expectation(description: "expect searchMovie() to be called")
        usecase.getMovieListCalled = expect
        // act
        textSearch.onNext("")
        selectionGenre.onNext([])
        textSearch.onNext("abcd")
        
        // expect
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_selectGenres_searchMovie() {
        let expect = self.expectation(description: "expect searchMovie() to be called")
        usecase.getMovieListCalled = expect
        // act
        selectionGenre.onNext([])
        textSearch.onNext("")
        selectionGenre.onNext([IndexPath(row: 1, section: 0)])
        
        // expect
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_loadTrigger_getMoviesList_failedShowError() {
       
        let moviesListReturn = PublishSubject<PagingInfo<Movie>>()
        usecase.movieListReturn = moviesListReturn.asObserver()
        
        // act
        textSearch.onNext("")
        selectionGenre.onNext([])
        loadTrigger.onNext(())
        moviesListReturn.onError(TestError())
        let error = try! output.error.toBlocking().first()
        
        // expect
        XCTAssert(error is TestError)
    }
    
}
