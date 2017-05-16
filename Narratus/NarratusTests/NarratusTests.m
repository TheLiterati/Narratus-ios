//
//  NarratusTests.m
//  NarratusTests
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "API.h"

@interface NarratusTests : XCTestCase

@end

@implementation NarratusTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

+ (void)testSampleStory {
    id storyArray = [API sampleStory];
    Story *story = storyArray[0];
    XCTAssert([storyArray isKindOfClass:[NSMutableArray class]], @"storyArray is not an instance of NSMutableArray");
    XCTAssertFalse([storyArray isEmpty], @"storyArray is empty");
    XCTAssert([storyArray[0] isKindOfClass:[Story class]], @"story is not of class story");
    XCTAssertNotNil(story.ownerUserName);
    XCTAssertNotNil(story.ownerID);
    XCTAssertNotNil(story.title);
    XCTAssertNotNil(story.storyDescription);
    XCTAssertNotNil(story.createdDate);
    XCTAssertNotNil(story.lastUpdatedDate);
    XCTAssertNotNil(story.category);
    XCTAssertNotNil(story.open);
    XCTAssertNotNil(story.storySnippets);
    XCTAssertNotNil(story.storySnippetCount);
    XCTAssertNotNil(story.pendingSnippets);
    XCTAssertNotNil(story.pendingSnippetCount);
    XCTAssertNotNil(story.storyID);
}

+ (void)testSampleUser {
    id users = [API sampleUser];
    User *user = users[0];
    
}

+ (void)testSampleSnippet {
    
}

@end


//XCTAssertEqualObjects
//XCTAssertNotEqualObjects
//XCTAssertEqual
//XCTAssertNotEqual
//XCTAssertGreaterThan
//XCTAssertGreaterThanOrEqual
//XCTAssertLessThan
//XCTAssertLessThanOrEqual
//XCTAssertNil
//XCTAssertNotNil
//XCTAssertTrue
//XCTAssertFalse
