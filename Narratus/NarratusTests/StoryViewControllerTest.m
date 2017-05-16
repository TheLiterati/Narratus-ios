//
//  StoryViewControllerTest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StoryViewController.h"
#import "API.h"

@interface StoryViewControllerTest : XCTestCase

@property (strong, nonatomic) UIStoryboard *testStoryboard;
@property (strong, nonatomic) StoryViewController *testController;

@end

@implementation StoryViewControllerTest

- (void)setUp {
    [super setUp];
    self.testStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.testController = [self.testStoryboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    id storyArray = [API sampleStory];
    self.testController.currentStory = storyArray[0];
    
    
}

- (void)tearDown {
    self.testController = nil;
    self.testStoryboard = nil;
    [super tearDown];
}

- (void)testValidStory {
    XCTAssertNotNil([self.testController currentStory], @"Story was nil");
}

@end
