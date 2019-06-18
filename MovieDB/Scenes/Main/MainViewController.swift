//
//  MainViewController.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

final class MainViewController: UITabBarController, BindableType {
    
    // MARK: - Propeties
    var viewModel: MainViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    func bindViewModel() {
        
    }
}

extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
