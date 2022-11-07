# TCA_Study


## TCA

- 참고
	- [SwiftUI에서 MVVM을 사용해야 하는가?](https://green1229.tistory.com/267)
	- [Stop using MVVM for SwiftUI](https://developer.apple.com/forums/thread/699003)

- MVVM 왜 사용하지 말아야 하는가?
	- MVVM은 데이터 바인딩 + 로직을 위한 느낌이 강한데 데이터 바인딩은 이미 SwiftUI 에서 데이터 바인딩은 이미 하고 있으니 다른 구조가 필요하다
		- (아직 적용해보지 않아 이해가 되지 않음.)

	- 상태 관리 기반의 단반향 아키텍처를 사용하는 것이 좋다.
	- MVVM의 경우 비즈니스 로직을 담고 프로퍼티를 만들어 다시 바인딩하는 형식이기 때문에 리바인딩하는 불필요한 방식이 추가되므로 비추. 

- 선언형 UI에서 새로운 구조가 필요하다.
	- View와 비지니스 로직의 분리
	- 단방향의 데이터 플로우
	- 각 view와 비지니스 로직의 분리
	- view를 통해 나타낼 Component의 설계 및 조합
	- Component들의 상태 관리 및 연결

- TCA의 단점
	- State, Action, Reducer를 만드는 작업이 선행으로 이루어져야해서 작은 단위의 프로젝트에는 배보다 배꼼이 더 클수 있음


## TCA 사용법

- 흐름
	- action을 보내 store가 reducer와 effect를 실행하고, store에서 일어나는 상태(state) 변화를 관측(observe)해서 UI를 업데이트할 수도 있다.

- 꽤 크고 복잡한 기능을 결합가능한 작고 독립된 모듈로 쪼갤 수 있다.

- State
	- 데이터 상태
	- 로직 수행이나 UI를 그릴 때 필요한 데이터

- Action
	- 도메인 액션
	- 사용자가 하는 행동이나 노티피케이션 등 app내에 생길 수 있는 모든 행동

- Environment
	- API 클라이언트나 애널리틱스 클라이언트와 같이 어플리케이션이 필요로 하는 의존성(Dependency)갖는 타입

- Store
	- 커맨드 센터
	- state, action 가지고 있음
	- 기능이 작동하는 공간

- Reducer
	- action과 state를 연결시켜주는 역할
	- 들어온 action에 따라 state를 변화시켜주는 역할
	- Action이 주어졌을 때 현재 State를 다음 상태로 변화시키는 방법 갖는 함수
	- 실행할 수 있는 effect(ex. api request)를 반환해야한다 

## TCA 적용기

초반

중반

후반
