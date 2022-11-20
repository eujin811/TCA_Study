//
//  TCA_Notice_exApp.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/07.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_Notice_exApp: App {
    let noticeListStore = Store(
        initialState: NoticeListReduce.State(),
        reducer: NoticeListReduce())
    
    var body: some Scene {
        WindowGroup {
            NoticeListView(store: noticeListStore)
        }
    }
}
