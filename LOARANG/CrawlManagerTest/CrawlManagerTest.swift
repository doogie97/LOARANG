//
//  CrawlManagerTest.swift
//  CrawlManagerTest
//
//  Created by 최최성균 on 2022/05/26.
//

import XCTest
@testable import LOARANG


class CrawlManagerTest: XCTestCase {
    var sut: CrawlManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CrawlManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_getCharacterTitle호출시_userName이_최지근일때_길드이름을잘가져오는지(){
        //given
        let userName = "최지근"
        
        //when
        do {
            let result = try sut.searchUser(userName: userName)
            //then
            XCTAssertEqual(result.basicInfo.guild, "미지근")
        } catch {
            XCTFail()
        }
    }
}
