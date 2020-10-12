//
//  ForcaTests.swift
//  ForcaTests
//
//  Created by Ricardo Carra Marsilio on 06/10/20.
//

import XCTest
@testable import Forca

class ForcaTests: XCTestCase {

    func testExample() throws {
        let palavra = "CACHORRO"
        var mascara = "________"
        
        mascara = troca("R", na: mascara, com: palavra)
        XCTAssert(mascara == "_____RR_", mascara)
        
        
        mascara = troca("X", na: mascara, com: palavra)
        XCTAssert(mascara == "_____RR_", mascara)
    }

}
