//
//  AppDelegate.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var assembler: Assembler = DefaultAssembler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if NSClassFromString("XCTest") != nil { // test
            window?.rootViewController = UnitTestViewController()
        } else {
            bindViewModel()
        }
        return true
    }

    private func bindViewModel() {
        guard let window = window else { return }
        let vm: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = vm.transform(input)
        output.toMain
              .drive()
              .disposed(by: DisposeBag())
    }
    
}

