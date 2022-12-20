//
//  LOARANG_MVVMTests.swift
//  LOARANG-MVVMTests
//
//  Created by 최최성균 on 2022/12/11.
//

import XCTest
@testable import LOARANG_MVVM

final class LOARANG_MVVMTests: XCTestCase {
    func test_Requset호출시_News정보를_잘_가져오는지() async {
        //given
        let networkManager = NetworkManager()
        let api = NewsAPIModel()
        
        //when
        do {
            //then
            let news = try await networkManager.request(api, resultType: [News].self)
            XCTAssertEqual(news[safe: 0]?.title, "2022 3rd 네리아의 드레스룸")
        } catch let error {
            debugPrint(error)
            XCTFail()
        }
    }
    
    func test_Requset호출시_Characters정보를_잘_가져오는지() async {
        //given
        let networkManager = NetworkManager()
        let api = CharactersAPIModel(name: "최지근")
        
        //when
        do {
            //then
            let characters = try await networkManager.request(api, resultType: [CharacterInfo].self)
            XCTAssertEqual(characters.first?.characterName, "스고히")
        } catch let error {
            debugPrint(error)
            XCTFail()
        }
    }
    
    func test_Requset호출시_MarketOptions를_잘_가져오는지() async {
        //given
        let networkManager = NetworkManager()
        let api = MarketOptionsAPI()
        
        //when
        do {
            //then
            let marketOptions = try await networkManager.request(api, resultType: MarketOptions.self)
            XCTAssertEqual(marketOptions.categories[safe: 4]?.subs[safe: 0]?.codeName, "배틀 아이템 -회복형")
            XCTAssertEqual(marketOptions.classes[3], "홀리나이트")
        } catch let error {
            debugPrint(error)
            XCTFail()
        }
    }
    
    func test_Requset호출시_검색된MarketItem들을_잘_가져오는지() async {
        //given
        let networkManager = NetworkManager()
        let searchOption = SearchMarketItemsAPI.SearchOption(sort: .grade,
                                                             categoryCode: 20005,
                                                             characterClass: "블레이드",
                                                             itemTier: .all,
                                                             itemGrade: .all,
                                                             itemName: "여름빛",
                                                             pageNo: 0,
                                                             sortCondition: .asc)
        let api = SearchMarketItemsAPI(searchOption: searchOption)
        
        do {
            //then
            let marketSearchResponse = try await networkManager.request(api, resultType: MarketSearchResponse.self)
            XCTAssertEqual(marketSearchResponse.items[safe:0]?.grade, "1000")
        } catch let error {
            debugPrint(error)
            XCTFail()
        }
    }
}
