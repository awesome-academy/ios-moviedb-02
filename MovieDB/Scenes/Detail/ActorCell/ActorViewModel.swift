//
//  ActorViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

struct ActorViewModel {
    let actor: Actor
}

extension ActorViewModel {
    var character: String {
        return actor.character
    }
    
    var name: String {
        return actor.name
    }
    
    var profilePath: String {
        return actor.profilePath
    }
}
