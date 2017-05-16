//
//  OwnedStorySnippetViewControllerTest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OwnedStorySnippetViewController.h"
#import "API.h"

@interface OwnedStorySnippetViewControllerTest : XCTestCase

@property (strong, nonatomic) UIStoryboard *testStoryboard;
@property (strong, nonatomic) OwnedStorySnippetViewController *testController;

@end

@implementation OwnedStorySnippetViewControllerTest

- (void)setUp {
    [super setUp];
    self.testStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.testController = [self.testStoryboard instantiateViewControllerWithIdentifier:@"OwnedStorySnippetViewController"];
    [self.testController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
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


-(void)testThatViewLoads {
    XCTAssertNotNil(self.testController.view, @"View not initiated properly");
}


@end
