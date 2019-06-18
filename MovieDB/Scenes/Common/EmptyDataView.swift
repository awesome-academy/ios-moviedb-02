//
//  EmptyDataView.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import UIKit

final class EmptyDataView: UIView, NibOwnerLoadable {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

}
