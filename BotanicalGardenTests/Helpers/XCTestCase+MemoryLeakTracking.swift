//
//  XCTestCase+MemoryLeakTracking.swift
//  BotanicalGardenTests
//
//  Created by 黃偉勛 Terry on 2021/9/9.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
