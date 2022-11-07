//
//  CalculatorView.swift
//  TCA_simple_tutorial
//
//  Created by YoujinMac on 2022/11/07.
//

import SwiftUI
import CombineSchedulers
import ComposableArchitecture

struct CalculatorReduce: ReducerProtocol {
    struct State: Equatable {
        var count = 0
        var numberFactAlert: String?
    }
    
    enum Action: Equatable {
        case factAlertDismised
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFatButtonTapped
        case numberFactResponse(TaskResult<String>)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .factAlertDismised:
            state.numberFactAlert = nil
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
            
        case .numberFatButtonTapped:
            return .task { [count = state.count] in
                await .numberFactResponse(
                    TaskResult {
                        String(decoding: try await URLSession.shared
                            .data(from: URL(string: "http://numbersapi.com/\(count)/trivia")!).0,
                               as: UTF8.self)
                    }
                )
            }
            
        case .numberFactResponse(let result):
            switch result {
            case .success(let fact):
                state.numberFactAlert = fact
                return .none
                
            case .failure:
                state.numberFactAlert = "could not load a number fact :("
                return .none
            }
        }
    }
}

struct CalculatorView: View {
    let store: StoreOf<CalculatorReduce>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped) }
                }
                
                Button("Number fact") { viewStore.send(.numberFatButtonTapped) }
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(CalculatorAlert.init(title:))},
                    send: .factAlertDismised),
                content: { Alert(title: Text($0.title))})
        
        }
    }
}


struct CalculatorAlert: Identifiable {
  var title: String
  var id: String { self.title }
}
