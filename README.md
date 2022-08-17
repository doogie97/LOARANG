# LOARANG(로아랑)
![스크린샷 2022-08-17 오후 3 24 41](https://user-images.githubusercontent.com/82325822/185049637-86c3e138-9841-4707-9cd5-bc70380b5835.png)

## 💁🏻‍♂️ 프로젝트 소개
로스트 아크 유저들을 위한 유저 검색 및 정보 제공 어플!! 
(은 많지만 이제 디자인이 제일 이쁘다고 자신 할 수 있는...!)

## 실행 화면
|유저 검색|북마크 등록&해제|메인 유저 등록|
|:-:|:-:|:-:|
|![](https://i.imgur.com/10ZAi1Q.gif)|![](https://i.imgur.com/OBJh2vJ.gif)|![](https://i.imgur.com/h0CtzR0.gif)|

|셀 터치를 통한 검색|유저 정보 화면 전환|캐릭터 이미지 공유|
|:-:|:-:|:-:|
|![](https://i.imgur.com/7LGaHpZ.gif)|![](https://i.imgur.com/OYEGdEf.gif)|![](https://i.imgur.com/CM0xYmu.gif)|

## UserModel 구조
<img width="9648" alt="UserInfoModel" src="https://user-images.githubusercontent.com/82325822/178917346-4d58942b-e309-4277-beab-d3dbcf3afca5.png">

## 기능 구현
- RxSwift를 통한 반응형 프로그래밍
- SwiftSoup를 이용한 공식홈페이지의 유저 정보 크롤링
- Realm을 통한 대표캐릭터 및 북마크 유저 로컬 저장 기능
- TableView와 CollectionView 중첩을 통한 화면 구성


## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.3.1-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.0.1-skyblue)]()
- [![swift](https://img.shields.io/badge/Realm-10.28.2-pink)]()
- [![xcode](https://img.shields.io/badge/SwiftSoup-2.4.2-red)]()
- [![xcode](https://img.shields.io/badge/SwiftyJSON-5.0.1-green)]()


## 🚀 Trouble Shooting

### 이전에 만들던 동일한 프로젝트가 있으나 새로 시작한 이유
- MVC로 만드려고 했으나 기능 구현에 급급해 닥치는대로 만들다 보니 유지보수가 매우 어려운 프로젝트가 되었다
- 그러던 중 다른 프로젝트([프로젝트 관리 앱](https://github.com/doogie97/ios-project-manager))을 진행하다 Rx 및 MVVM디자인 패턴을 접했으며 해당 디자인 패턴으로 구현하면 유지보수가 더 쉽고 정리도 잘 될 것이라는 판단으로 새롭게 시작


## 커밋 룰
Commit message
커밋 제목은 최대 50자 입력

💎feat : 새로운 기능 구현

✏️chore : 사소한 코드 수정, 내부 파일 수정, 파일 이동 등

🔨fix : 버그, 오류 해결

📝docs : README나 WIKI 등의 문서 개정

♻️refactor : 수정이 있을 때 사용 (이름변경, 코드 스타일 변경 등)

⚰️del : 쓸모없는 코드 삭제
