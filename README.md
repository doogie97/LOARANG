# LOARANG(로아랑)

## [앱스토어에서 다운로드](https://apps.apple.com/kr/app/%EB%A1%9C%EC%95%84%EB%9E%91/id6444625201)
![내 프로젝트](https://user-images.githubusercontent.com/82325822/206885010-0e67a6e1-3f8c-4b2e-b1f1-80ea0a2bd059.png)

## 💁🏻‍♂️ 프로젝트 소개
![](https://i.imgur.com/FIerZnA.png)
로스트 아크 유저들을 위한 유저 검색 및 정보 제공 어플!! 
(현재 로스트아크의 공식 API 출시로 어플 개편에 있으며 곧 더 원활한 서비스 제공을 하도록 하겠습니다!)

## 실행 화면
|유저 검색|북마크 등록&해제|대표 캐릭터 설정|
|:-:|:-:|:-:|
|![](https://i.imgur.com/cuKzCtU.gif)|![](https://i.imgur.com/pLdyYhW.gif)|![](https://i.imgur.com/aqdfG5Q.gif)|

|셀 터치를 통한 검색|유저 정보 화면 전환|유저 정보 상세|
|:-:|:-:|:-:|
|![](https://i.imgur.com/EUZcBXn.gif)|![](https://i.imgur.com/uUbepmi.gif)|![ㄹ (1)](https://user-images.githubusercontent.com/82325822/190354421-847dbc33-f818-45ff-b72c-3df21cc94d83.gif)|


## UserModel 구조
<img width="9648" alt="UserInfoModel" src="https://user-images.githubusercontent.com/82325822/178917346-4d58942b-e309-4277-beab-d3dbcf3afca5.png">

## 기능 구현
- RxSwift를 통한 반응형 프로그래밍
- SwiftSoup를 이용한 공식 홈페이지의 유저 정보 크롤링
- Realm을 통한 대표 캐릭터 및 북마크 유저 로컬 저장 기능


## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.3.1-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.0.1-skyblue)]()
- [![swift](https://img.shields.io/badge/Realm-10.28.2-pink)]()
- [![xcode](https://img.shields.io/badge/SwiftSoup-2.4.2-red)]()
- [![xcode](https://img.shields.io/badge/SwiftyJSON-5.0.1-green)]()


## 🚀 Trouble Shooting

### 📌 ScrollView 내에 segmentControl를 드래그 할 경우 스크롤이 되지 않는 현상
![](https://i.imgur.com/WPcTqxv.gif)

segmentControl 부분을 아무리 스크롤 해도 스크롤 뷰가 넘어가지 않고 밑에 살짝 남은 scrollView 부분을 스크롤 해야 뷰가 넘어가는 현상이 있었다
(제스처 인식이 스크롤 뷰 보다 세그먼트 컨트롤이 먼저 인식이 되어 스크롤이 되지 않는 현상이라고 추측했으며 실제로 스크롤 뷰를 드래그하기 위해 터치했을 때 세그먼트가 선택되는 현상을 볼 수 있었음)

#### 🤔 해결 방법
스크롤 뷰를 사용하는 다른 뷰 내부에 컬렉션 뷰 혹은 테이블 뷰가 있는데도 스크롤이 잘 되는 것을 미루어 보았을 때 컬렉션 뷰로 세그먼트 컨트롤을 만들어버리면 문제가 해결될 것이라고 생각했다

즉, segmentControl을 커스텀 한 기존의 방식이 아닌 collection View를 통해 아예 segmentControl을 새로 만들어버렸다
![](https://i.imgur.com/dDANHsr.gif)

만들면서 선택되었을 때아닐 때의 폰트, 색상, 정렬을 설정하는 기능도 추가해 이전 보다 더 유연하게 사용할 수 있도록 기능 추가

(결과적으로 스크롤 뷰 내에 세그먼트 컨트롤을 넣는 기능은 사용하지 않기로 했지만 이번 구현으로 인해 추후 다른 프로젝트에서도 이 기능이 필요하다면 해당 파일을 가져다가 사용 가능할듯하다)


### 📌 새로고침 기능 추가(+ RxSwift 사용에 대한 이유..?)

![](https://i.imgur.com/9ZHtM1i.png)

유저 검색식 간혹 위와 같이 정보를 이상하게 받아올 때가 있었고 사용자의 편의를 위해 새로고침 기능을 넣고자 했는데 큰 문제가 있었다

기존 방식은 UserInfoView를 보여주기 전 미리 검색해서 단순히 UserInfo만 넘겨주기 때문에 새로운 정보를 받아와도 뷰가 새로고침 되지 않는 이상 반영이 불가했다
(정보가 바뀌면 뷰에도 즉각 반영되는 편리함 때문에 RxSwift를 사용하지만 그 기능을 전혀 사용하고 있지 않다는 말이었다…)

그래서 3일에 걸친 대 공사를 시작하게 됐는데…

#### 🤔 해결 방법
하나의 큰 뷰에서 `BehaviorRelay<UserInfo>`를 갖고 있고 하위 뷰들에게 이것을 주입해 주는 식으로 해서 큰 뷰에서 새로고침 버튼을 터치해 UserInfo가 바뀌게 된다면 이걸 바라보고 있는 하위 뷰들 또한 모두 바뀌도록 수정하고자 했다

`(여기서 가장 큰 뷰 = 기본 정보, 스킬, 보유캐릭터를 갖고 있는 PageViewController를 또 갖고 있는 UserInfoView가 되겠슴다)`

#### 수정 순서는 아래와 같다
1. 검색 후 유저 정보를 넘겨주는 것이 아는 유저 인포 뷰로 들어감과 동시에 검색 기능 구현 및 BehaviorRelay<UserInfo>생성
2. 각각 하위 뷰들이 BehaviorRelay<UserInfo>를 주입받아 이것을 통해 뷰 표시 구현할 수 있도록 전면 수정

글로만 보면 너무나도 간단한 일 같지만 이게 3일이나 걸린 이유는 구조를 갈아 =엎어버리는 대공사가 필요했으며 어떻게 구현해야 할지 고민 및 시행착오를 겪어 3일이라는 시간이 걸리지 않았나 싶다

![](https://i.imgur.com/xpvNnPe.gif)

(그래도 결과적으로는 구현 완료했으니 만족! 다만 코드를 조금 정리할 필요는 있겠다)
  
### 📌 JSON정보를 가져올 때 Swifty JSON을 이용해 가져온 이유
![](https://i.imgur.com/FLexgmi.png)

![](https://i.imgur.com/56nl8Fs.png)
같은 정보를 가져옴에 있어서 key값이 달라져서 이 부분을 어떻게 가져올지 판단이 서지 않아 위 정보를 예시로 들었을 때 '002를 포함한 카드정보를 가져오기'를 구현하기 위해 Swifty JSON을 통해 가져오게 되었다



## 커밋 룰
커밋 제목은 최대 50자 입력

💎feat : 새로운 기능 구현

✏️chore : 사소한 코드 수정, 내부 파일 수정, 파일 이동 등

🔨fix : 버그, 오류 해결

📝docs : README나 WIKI 등의 문서 개정

♻️refactor : 수정이 있을 때 사용 (이름변경, 코드 스타일 변경 등)

⚰️del : 쓸모없는 코드 삭제
