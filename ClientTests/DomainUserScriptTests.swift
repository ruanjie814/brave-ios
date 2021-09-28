// Copyright 2021 The Brave Authors. All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
@testable import Client

class DomainUserScriptTests: XCTestCase {

    func testBraveSearchAPIAvailability() throws {
        let goodURLs = [URL(string: "https://search.brave.com"),
                        URL(string: "https://search-dev.brave.com"),
                        URL(string: "https://search.brave.com/custom/path"),
                        URL(string: "https://search-dev.brave.com/custom/path")].compactMap { $0 }
        
        goodURLs.forEach {
            XCTAssert(DomainUserScript.get(for: $0) == .braveSearch)
        }
        
        let badURLs = [URL(string: "https://talk.brave.com"),
                        URL(string: "https://search.brave.software.com"),
                       URL(string: "https://community.brave.com"),
                       URL(string: "https://subdomain.search.brave.com"),
                       URL(string: "https://brave.com")].compactMap { $0 }
        
        badURLs.forEach {
            XCTAssertFalse(DomainUserScript.get(for: $0) == .braveSearch)
        }
    }
    
    func testBraveTalkAPIAvailability() throws {
        
        let goodURLs = [URL(string: "https://talk.brave.com"),
                        URL(string: "https://beta.talk.brave.com"),
                        URL(string: "https://talk.bravesoftware.com"),
                        URL(string: "https://beta.talk.bravesoftware.com"),
                        URL(string: "https://dev.talk.brave.software"),
                        URL(string: "https://beta.talk.brave.software"),
                        URL(string: "https://talk.brave.com/account")].compactMap { $0 }
        
        goodURLs.forEach {
            XCTAssert(DomainUserScript.get(for: $0) == .braveTalk)
        }
        
        let badURLs = [URL(string: "https://search.brave.com"),
                       URL(string: "https://search-dev.brave.com"),
                       URL(string: "https://search.brave.com/custom/path"),
                       URL(string: "https://search-dev.brave.com/custom/path"),
                       URL(string: "https://community.brave.com"),
                       URL(string: "https://subdomain.brave.com"),
                       URL(string: "https://brave.com")].compactMap { $0 }
        
        badURLs.forEach {
            XCTAssertFalse(DomainUserScript.get(for: $0) == .braveTalk)
        }
    }
}