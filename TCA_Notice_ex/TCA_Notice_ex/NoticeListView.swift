//
//  ContentView.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/07.
//

import Combine
import SwiftUI

import Alamofire
import ComposableArchitecture

struct NoticeListReduce: ReducerProtocol {
    private var cancelBag = Set<AnyCancellable>()
    
    struct State {
        var noticeList = [NoticeList.NoticeItem]()
    }
    
    enum Action: Equatable {
        static func == (lhs: NoticeListReduce.Action, rhs: NoticeListReduce.Action) -> Bool {
            return lhs.self == rhs.self
        }
        
        case showNoticeList
        case convertToNoticeList(NoticeList)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .showNoticeList:
            guard let url = URL(string: Constants.sever.noticeListURL) else { return .none }
            
            let action = AF.request(Constants.sever.noticeListURL,
                                    method: .get,
                                    parameters: nil,
                                    encoding: URLEncoding.default,
                                    headers: nil)
                .publishDecodable(type: NoticeList.self)
                .value()
                .receive(on: DispatchQueue.main)
                .catchToEffect()
                .map { response -> NoticeListReduce.Action in
                    switch response {
                    case .success(let noticeList):
                        return NoticeListReduce.Action.convertToNoticeList(noticeList)
                        
                    case .failure(let error):
                        print("failure, response \(error)")
                        return .none
                    }
                    
                }
            
            
            return action
        case .convertToNoticeList(let noticeList):
            switch noticeList.code {
            case 1000:
                state.noticeList = noticeList.list
                return .none
                
            default:
                print("서버에러 notice code \(noticeList.code)")
                return .none
            }
        }
    }
    

}

struct NoticeListView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct NoticeDetail_Previews: PreviewProvider {
    static var previews: some View {
        NoticeListView()
    }
}
