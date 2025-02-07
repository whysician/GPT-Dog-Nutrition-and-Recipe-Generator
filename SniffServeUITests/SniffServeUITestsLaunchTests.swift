//
//  GPT_Dog_Nutrition_and_Recipe_GeneratorUITestsLaunchTests.swift
//  GPT-Dog-Nutrition-and-Recipe-GeneratorUITests
//
//  Created by Victoria Sok on 1/29/25.
//

import XCTest

final class GPT_Dog_Nutrition_and_Recipe_GeneratorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
