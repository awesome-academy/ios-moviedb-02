//
//  YT+Rx.swift
//  Project2
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import YoutubeKit

extension Reactive where Base: YTSwiftyPlayer {
    var settingVideo: Binder<String> {
        return Binder<String>(base, binding: { yt, link in
            yt.setPlayerParameters([.playsInline(true) ,
                                    .showInfo(false),
                                    .alwaysShowCaption(false),
                                    .showRelatedVideo(false),
                                    .videoID(link)])
            yt.loadPlayer()
        })
    }
}
