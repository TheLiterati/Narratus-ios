//
//  StoryTableViewControllerTest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StoryTableViewController.h"
#import "API.h"

@interface StoryTableViewControllerTest : XCTestCase

@property (strong, nonatomic) UIStoryboard *testStoryboard;
@property (strong, nonatomic) StoryTableViewController *testController;

@end

@implementation StoryTableViewControllerTest

- (void)setUp {
    [super setUp];
    self.testStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.testController = [self.testStoryboard instantiateViewControllerWithIdentifier:@"StoryTableViewController"];
    id storyArray = [API sampleStory];
    self.testController.selectedStory = storyArray[0];
    
    
}

- (void)tearDown {
    self.testController = nil;
    self.testStoryboard = nil;
    [super tearDown];
}

- (void)testValidStory {
    XCTAssertNotNil([self.testController selectedStory], @"Story was nil");
}


@end
