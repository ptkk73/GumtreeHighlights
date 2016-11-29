//
//  TestApp_DataDownloaderTests.swift
//  TestApp_DataDownloaderTests
//
//  Created by Piotr Kożuch on 16/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import XCTest
import TestApp_DataDownloader
@testable import TestApp_DataDownloader

class CollectionUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTransform() {
        let intCollection = [1, 24, 5, 67, 890, 0]
        let strCollection = ["1", "24", "5", "67", "890", "0"]
        
        XCTAssert(CollectionUtils.transform(collection: intCollection)
        {
            String($0)
        } == strCollection)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
