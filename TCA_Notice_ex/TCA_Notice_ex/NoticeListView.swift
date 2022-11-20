//
//  ContentView.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/07.
//

import Combine
import CombineSchedulers
import SwiftUI

import Alamofire
import ComposableArchitecture

struct NoticeListReduce: ReducerProtocol {
    struct State: Equatable {
        static func == (lhs: NoticeListReduce.State, rhs: NoticeListReduce.State) -> Bool {
            return lhs.self == rhs.self
        }
        
        var noticeList = [NoticeList.NoticeItem]()
    }
    
    enum Action: Equatable {
        static func == (lhs: NoticeListReduce.Action, rhs: NoticeListReduce.Action) -> Bool {
            return lhs.self == rhs.self
        }
        
        
        case showNoticeList
        case responseNoticeList(TaskResult<NoticeList>)
        
     }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
//        case .showNoticeList:
//            guard let url = URL(string: Constants.sever.noticeListURL) else { return .none }
//
//            return .task {
//                let data = AF.request(Constants.sever.noticeListURL,
//                                      method: .get,
//                                      parameters: nil,
//                                      encoding: URLEncoding.default,
//                                      headers: nil)
//                    .publishDecodable(type: NoticeList.self)
//                    .value()
//            }

            //            return apiManager
            //                .reqestNoticeList()
            //                .catchToEffect(.r esponseNoticeList($0))
            
        case .showNoticeList:
            return .task {
                // error -> Trailing closure passed to parameter of type 'TaskResult<NoticeList>' that does not accept a closure
                
                await .responseNoticeList {
                    TaskResult {
                        NoticeClient().requestNoticeList()
                    }
                }
            }
            
        case .responseNoticeList(.success(let noticeList)):
            switch noticeList.code {
            case 1000:
                state.noticeList = noticeList.list
            default:
                print("sever error: code \(noticeList.code)")
            }
            
            return .none
            
        case .responseNoticeList(.failure(let error)):
            print("fail response \(error)")
            return .none
        }
    }
    
}

struct NoticeListView: View {
    let store: StoreOf<NoticeListReduce>
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

//struct NoticeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NoticeListView(store: <#StoreOf<NoticeListReduce>#>)
//    }
//}
