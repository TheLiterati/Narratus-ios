//
//  UserDashboardViewControllerTest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserDashboardViewController.h"
#import "API.h"

@interface UserDashboardViewControllerTest : XCTestCase

@property (strong, nonatomic) UIStoryboard *testStoryboard;
@property (strong, nonatomic) UserDashboardViewController *testController;

@end

@implementation UserDashboardViewControllerTest

- (void)setUp {
    [super setUp];
    self.testStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.testController = [self.testStoryboard instantiateViewControllerWithIdentifier:@"UserDashboardViewController"];
    id userArray = [API sampleUser];
    self.testController.user = userArray[0];
    
    
}

- (void)tearDown {
    self.testController = nil;
    self.testStoryboard = nil;
    [super tearDown];
}

- (void)testValidUser {
    XCTAssertNotNil([self.testController user], @"User was nil");
}


@end
