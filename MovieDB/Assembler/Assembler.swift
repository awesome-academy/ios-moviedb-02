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
    DetailAssembler,
    AppAssembler {
    
}

final class DefaultAssembler: Assembler {
}
