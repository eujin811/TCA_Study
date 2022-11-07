//
//  ContentView.swift
//  TCA_simple_tutorial
//
//  Created by YoujinMac on 2022/11/07.
//

import SwiftUI
import ComposableArchitecture

// 데이터 상태
struct CounterState: Equatable {
    var count: Int = 0
//    var nuberFactAlert: String?
}

// 도메인 + 액션
enum CounterAction: Equatable {
    case addCount               // +
    case substractCount         // -
}

// API 클라이언트나 애널리틱스 클라이언트와 같이 어플리케이션이 필요로하는 의존성갖는 타입
struct CounterEnvironment {}

// action과 state를 연결시켜주는 역할 effect 반환
let counterReducer = Reducer<
    CounterState,
    CounterAction,
    CounterEnvironment> { state, action, evironment in
        switch action {
        case .addCount:
            state.count += 1
            return .none
            
        case .substractCount:
            state.count -= 1
            return .none
            
        }
    }

//struct CounterReducer: Reduce<CounterState, CounterAction> {
//
//}


struct CounterView: View {
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .padding()
                
                HStack {
                    Button("더하기") { viewStore.send(.addCount) }
                    Button("빼기") { viewStore.send(.substractCount) }
                }
            }
        }
    }
}

//struct CounterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CounterView(store: <#Store<CounterState, CounterAction>#>)
//    }
//}
