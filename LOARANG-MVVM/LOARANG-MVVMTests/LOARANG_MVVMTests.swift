//
//  LOARANG_MVVMTests.swift
//  LOARANG-MVVMTests
//
//  Created by 최최성균 on 2022/12/11.
//

import XCTest
@testable import LOARANG_MVVM

final class LOARANG_MVVMTests: XCTestCase {
    func test_Requset호출시_News정보를_잘_가져오는지() {
        //given
        let promise = expectation(description: "News를 잘 가져오는지")
        let networkManager = NetworkManager()
        let api = NewsAPIModel()
        
        //when
        networkManager.request(api, resultType: [News].self) { result in
            switch result {
                //then
            case .success(let news):
                //2022년 12월11일 기준 첫 번째 이벤트
                XCTAssertEqual(news[safe: 0]?.title, "2022 3rd 네리아의 드레스룸")
            case .failure(let error):
                print(error)
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_Requset호출시_Characters정보를_잘_가져오는지() {
        //given
        let promise = expectation(description: "Characters를 잘 가져오는지")
        let networkManager = NetworkManager()
        let api = CharactersAPIModel(name: "최지근")
        
        //when
        networkManager.request(api, resultType: [CharacterInfo].self) { result in
            switch result {
            case .success(let characters):
                guard let character = characters.first else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(character.characterName, "스고히")
            case .failure(let error):
                print(error)
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_Requset호출시_MarketOptions를_잘_가져오는지() {
        //given
        let promise = expectation(description: "MarketOptions를 잘 가져오는지")
        let networkManager = NetworkManager()
        let api = MarketOptionsAPI()
        
        //when
        networkManager.request(api, resultType: MarketOptions.self) { result in
            switch result {
                //then
            case .success(let marketOptions):
                XCTAssertEqual(marketOptions.categories[safe: 4]?.subs[safe: 0]?.codeName, "배틀 아이템 -회복형")
                XCTAssertEqual(marketOptions.classes[3], "홀리나이트")
            case .failure(let error):
                print(error)
                XCTFail(error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_Requset호출시_검색된MarketItem들을_잘_가져오는지() {
        //given
        let promise = expectation(description: "MarketItem들을 잘 가져오는지")
        let networkManager = NetworkManager()
        let searchOption = SearchMarketItemsAPI.SearchOption(sort: .grade,
                                                             categoryCode: 20005,
                                                             characterClass: "블레이드",
                                                             itemTier: 0,
                                                             itemName: "핏빛",
                                                             pageNo: 0,
                                                             sortCondition: .asc)
        let api = SearchMarketItemsAPI(searchOption: searchOption)
        
        //when
        networkManager.request(api, resultType: MarketSearchResponse.self) { result in
            switch result {
                //then
            case .success(let marketSearchResponse):
                XCTAssertEqual(marketSearchResponse.items[safe:1]?.bundleCount, 1000)
            case .failure(let error):
                print(error)
                XCTFail(error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
