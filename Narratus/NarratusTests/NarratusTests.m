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
    XCTAssert([storyArray[0] isKindOfClass:[Story class]], @"story is not of class Story");
    XCTAssertNotNil(story.ownerUserName, @"story.ownerUserName is nil");
    XCTAssertNotNil(story.ownerID, @"story.ownerID is nil");
    XCTAssertNotNil(story.title, @"story.title is nil");
    XCTAssertNotNil(story.storyDescription, "story.storyDescription is nil");
    XCTAssertNotNil(story.createdDate, @"story.createdDate is nil");
    XCTAssertNotNil(story.lastUpdatedDate, @"story.lastUpdatedDate is nil");
    XCTAssertNotNil(story.category, @"story.category is nil");
    XCTAssertNotNil(story.open, @"story.open is nil");
    XCTAssertNotNil(story.storySnippets, @"story.storySnippets is nil");
    XCTAssertNotNil(story.storySnippetCount, @"storySnippetCount is nil");
    XCTAssertNotNil(story.pendingSnippets, @"story.pendingSnippets is nil");
    XCTAssertNotNil(story.pendingSnippetCount, @"story.pendingSnippetCount is nil");
    XCTAssertNotNil(story.storyID, @"story.storyID is nil");
}

+ (void)testSampleUser {
    id usersArray = [API sampleUser];
    User *user = usersArray[0];
    XCTAssert([usersArray isKindOfClass:[NSMutableArray class]], @"usersArray is not an isntance of NSMutableArray");
    XCTAssertFalse([usersArray isEmpty], @"users is empty");
    XCTAssert([usersArray[0] isKindOfClass:[User class]], @"user is not of class User");
    XCTAssertNotNil(user.userName, @"user.userName is nil");
    XCTAssertNotNil(user.password, @"user.password is nil");
    XCTAssertNotNil(user.email, @"user.email is nil");
    XCTAssertNotNil(user.ownedStories, @"user.ownedStories is nil");
    XCTAssertNotNil(user.followedStories, @"user.followedStories is nil");
    XCTAssertNotNil(user.userID, @"user.userID is nil");
    
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
