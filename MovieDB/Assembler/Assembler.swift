//
//  Assembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol Assembler: class,
    RepositoriesAssembler,
    MainAssembler,
    PopularListAssembler,
    UpcomingListAssembler,
    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
}
