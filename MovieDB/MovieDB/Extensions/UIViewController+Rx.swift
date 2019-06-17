//
//  UIViewController+Rx.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import SVProgressHUD

extension Reactive where Base: UIViewController {
    
    public var isAnimating: Binder<Bool> {
        return Binder(base) { vc, isVisible in
            let view = vc.navigationController?.view ?? vc.view
            let animation = isVisible ? {
                view?.alpha = 0.5
                view?.isUserInteractionEnabled = false
                SVProgressHUD.show() } : {
                    view?.alpha = 1
                    view?.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
            }
            animation()
        }
    }
    
    public var handlerErr: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showErrorAlert(errMessage: error.localizedDescription)
        }
    }
}

