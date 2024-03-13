//
//  UITestingView_UITests.swift
//  aboutSwiftUIAdvanced_UITests1
//
//  Created by Вадим Мартыненко on 01.11.2023.
//

import XCTest

final class UITestingView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
//        app.launchEnvironment = [
//            "-UITests_startSignedIn": "true"
//        ]
        
//         app.launchArguments = ["-UITests_startSignedIn"] // скипнет экран SignUp
        
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UITestingView_signUpButton_ShouldNotSignIn() {
        signUpAndSignIn(shouldTypeOnKeyBoard: false)
        
        let navBar = app.navigationBars["Welcome!"]
        
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestingView_signUpButton_ShouldSignIn() {
        
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        let navBar = app.navigationBars["Welcome!"]
        
        XCTAssertTrue(navBar.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        let navBar = app.navigationBars["Welcome!"]
        
        XCTAssertTrue(navBar.exists)
        
        tapAlertButton(shouldDismissAlert: false)
        
        let alert = app.alerts.firstMatch
        
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        let navBar = app.navigationBars["Welcome!"]
        
        XCTAssertTrue(navBar.exists)
        
        app.buttons["ShowAlertButton"].tap()
        
        tapAlertButton(shouldDismissAlert: true)
        
        let alertExist = app.alerts.firstMatch.waitForExistence(timeout: 5)
        
        XCTAssertFalse(alertExist)
    }
    
    func test_SignedInHomeView_NavigationLinkToDestination_shouldNavigationToDestinationAndGoBack() {
        
        signUpAndSignIn(shouldTypeOnKeyBoard: true)
        
        let navBar = app.navigationBars["Welcome!"]
        
        XCTAssertTrue(navBar.exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["NavigationLinkToDestination"]/*[[".buttons[\"Navigate\"]",".buttons[\"NavigationLinkToDestination\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let text = app.staticTexts["Destination"]
        
        XCTAssertTrue(text.exists)
        
        app.navigationBars.buttons["Welcome!"].tap()
        
        let backText = app.navigationBars["Welcome!"].staticTexts["Welcome!"]
        
        XCTAssertTrue(backText.exists)
    }
}

extension UITestingView_UITests {
    func tapAlertButton(shouldDismissAlert: Bool) {
        app.buttons["ShowAlertButton"].tap()
        
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch
            
            //  sleep(1)
            XCTAssertTrue(alert.exists)
            
            let cancelButton = alert.buttons["Cancel"]
            
            let alertCancelButtonExist = cancelButton.waitForExistence(timeout: 5)
            
            XCTAssertTrue(alertCancelButtonExist)
            
            cancelButton.tap()
        }
    }
    
    func signUpAndSignIn(shouldTypeOnKeyBoard: Bool) {
        app.textFields["SignUpTextField"].tap()
        
        if shouldTypeOnKeyBoard {
            app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            aKey.tap()
            aKey.tap()
            aKey.tap()
            aKey.tap()
        }
        
        app.buttons["SignUpButton"].tap()
    }
}
