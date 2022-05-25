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

    func test_getCharacterTitle호출시_최두기의칭호를잘가져오는지(){
        //given
        let userName = "최지근"
        
        //then
        let result = sut.getCharacterTitle(userName: userName)
        
        //then
        XCTAssertEqual(result, "그리운 친구")
    }
}
