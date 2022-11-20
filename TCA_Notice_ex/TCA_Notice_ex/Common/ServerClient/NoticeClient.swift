//
//  NoticeClient.swift
//  TCA_Notice_ex
//
//  Created by YoujinMac on 2022/11/20.
//

import Combine
import CombineSchedulers
import SwiftUI

import ComposableArchitecture

// API 통신
struct NoticeClient {
//    func requestNotice(_ id: String) -> Effect<, Failure> {
//        return Effect.task {
//            let url = URL(string: "\(Constants.sever.noticeDetailURL)?mb_id=\(id)")
//            let (data, error) = try await URLSession.shared.data(from: url!)
//
//            return try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//        }
//
//    }
    
    // effect -> 외부에서 일어난 일을 내부에서 처리하는
//    var requestNoticeList: () -> Effect<NoticeList, Failure>
    
    func requestNoticeList() -> Effect<NoticeList, Failure> {
        return Effect.task {
            let url = URL(string: Constants.sever.noticeListURL)
//            let data = try await URLSession.shared.dataTaskPublisher(for: url!)
            let (data, response) = try await URLSession.shared.data(from: url!)
            
            return try JSONDecoder().decode(NoticeList.self, from: data)
        }
        // error 형태 변환
        .mapError { _ in Failure() }
        .eraseToEffect()
        
//        let data = AF.request(Constants.sever.noticeListURL,
//                              method: .get,
//                              parameters: nil,
//                              encoding: URLEncoding.default,
//                              headers: nil)
//            .publishDecodable(type: NoticeList.self)
//            .value()
    }
    
    struct Failure: Error, Equatable {}
}
