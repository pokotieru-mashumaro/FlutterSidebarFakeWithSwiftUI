//
//  SideBarViewModel.swift
//  FlutterSidebarFakeWithSwiftUI
//
//  Created by 小松虎太郎 on 2023/06/03.
//

import SwiftUI

class SideBarViewModel: ObservableObject {
    @Published var isOpen: Bool = false
    @Published var sideButton: Bool = false
    @Published var selectedItem: TabIcon = .main
    @Published var toggleAction: Bool = false
}

struct SideBar: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var tab: TabIcon
}

var sidebar: [SideBar] = [
    .init(icon: "person", title: "通常", tab: .main),
    .init(icon: "person", title: "プロフィール", tab: .profile),
    .init(icon: "ellipsis.message", title: "メッセージ", tab: .message),
    .init(icon: "p.circle", title: "プレミアム", tab: .premium),
    .init(icon: "gear", title: "設定", tab: .setting),

]

enum TabIcon: String {
    case main
    case profile
    case message
    case premium
    case setting
}
