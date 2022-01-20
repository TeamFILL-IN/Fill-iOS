//
//  Notification.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/13.
//

import Foundation

extension Notification.Name {
    static let pushToFilmRollViewController = Notification.Name("pushToFilmRollViewController")
    static let pushToFilmSelectViewController = Notification.Name("pushToFilmSelectViewController")
    static let updateSelectedFilmType = Notification.Name("updateSelectedFilmType")
    static let changeMarker = Notification.Name("changeMarker")
    static let pushIdToContentViewController = Notification.Name("pushIdToContentViewController")
    static let selectedFilmAPI = Notification.Name("selectedFilmAPI")
}
