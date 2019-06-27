//
//  FavoriteListViewModelTest.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/24/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class FavoriteListViewModelTests: XCTestCase {
    
    var usecase: FavoriteListUseCaseMock!
    var navigator: FavoriteListNavigatorMock!
    var viewModel: FavoriteListViewModel!
    
    var input: FavoriteListViewModel.Input!
    var output: FavoriteListViewModel.Output!
    
    let disposeBag = DisposeBag()
    
    let selectionItem = PublishSubject<IndexPath>()
    let deletion = PublishSubject<IndexPath>()
    let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        usecase = FavoriteListUseCaseMock()
        navigator = FavoriteListNavigatorMock()
        viewModel = FavoriteListViewModel(usecase: usecase,
                                          navigator: navigator)
        
        let input = FavoriteListViewModel.Input(selection: selectionItem.asDriverOnErrorJustComplete(),
                                                deletion: deletion.asDriverOnErrorJustComplete(),
                                                loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        output.movieList
            .drive()
            .disposed(by: disposeBag)
        output.deletedMovie
            .drive()
            .disposed(by: disposeBag)
        output.selectedMovie
            .drive()
            .disposed(by: disposeBag)
    }
    
    func test_loadTrigger_LoadMovieList() {
        let expect = self.expectation(description: "Expect getMovieList() to be called ")
        usecase.expectationGetMovieListCalled = expect
        
        // act
        loadTrigger.onNext(())
        
        // expect
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_selection_DetailMovieCalled() {
        let expect = self.expectation(description: "Expect toDetailScene() to be called ")
        navigator.expectToDetail = expect
        
        // act
        loadTrigger.onNext(())
        selectionItem.onNext(IndexPath(row: 0, section: 1))
        
        // expect
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_deleteTrigger_showDeleteAlert() {
        let expect = self.expectation(description: "Expect showAlertDelete() to be called")
        navigator.expectShowAlertDelgate = expect
        
        loadTrigger.onNext(())
        deletion.onNext(IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_deleteTrigger_confirmDelete_DeleteMovie() {
        let deleteConfirm = PublishSubject<Movie>()
        let expect = self.expectation(description: "Expect delete() to be called")
        usecase.expectationDeleteMovieCalled = expect
        navigator.showAlertDelegateReturn = deleteConfirm
        loadTrigger.onNext(())
        deletion.onNext(IndexPath(row: 0, section: 0))
        deleteConfirm.onNext(Movie())
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
