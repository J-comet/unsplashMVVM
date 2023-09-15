//
//  TestSetting.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/15.
//

import Foundation

struct TestSetting: Hashable {
    let id = UUID().uuidString
    let title: String
    let imgName: String
    let subTitle: String
}

struct TestSettingInfo {
    static let list: [TestSetting] = [
        TestSetting(title: "disclosureIndicator", imgName: "square.and.arrow.up.circle", subTitle: "Side"),
        TestSetting(title: "outlineDisclosure", imgName: "eraser", subTitle: "Side"),
        TestSetting(title: "checkmark", imgName: "square.and.pencil", subTitle: "Bottom"),
        TestSetting(title: "delete", imgName: "trash", subTitle: "Bottom"),
        TestSetting(title: "insert", imgName: "pencil.tip", subTitle: ""),
        TestSetting(title: "multiselect", imgName: "folder.badge.plus", subTitle: ""),
        TestSetting(title: "label", imgName: "paperplane.fill", subTitle: ""),
        TestSetting(title: "customView", imgName: "bookmark.circle", subTitle: ""),
    ]
}
