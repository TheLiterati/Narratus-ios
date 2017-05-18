//
//  APITest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "API.h"

@interface APITest : XCTestCase

@end

@implementation APITest
- (void)setUp {
    [super setUp];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing asynchronous tasks!"];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSError *xctestError = [[NSError alloc]init];
        if (error) {
            NSLog(@"Expectation timed out: %@", xctestError.localizedDescription);
        }
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//+ (void)testSampleStory {
//    id storyArray = [API sampleStory];
//    Story *story = storyArray[0];
//    XCTAssert([storyArray isKindOfClass:[NSMutableArray class]], @"storyArray is not an instance of NSMutableArray");
//    XCTAssertFalse([storyArray isEmpty], @"storyArray is empty");
//    XCTAssert([storyArray[0] isKindOfClass:[Story class]], @"story is not of class Story");
//    XCTAssertNotNil(story.ownerUserName, @"story.ownerUserName is nil");
//    XCTAssertNotNil(story.ownerID, @"story.ownerID is nil");
//    XCTAssertNotNil(story.title, @"story.title is nil");
//    XCTAssertNotNil(story.storyDescription, "story.storyDescription is nil");
//    XCTAssertNotNil(story.createdDate, @"story.createdDate is nil");
//    XCTAssertNotNil(story.lastUpdatedDate, @"story.lastUpdatedDate is nil");
//    XCTAssertNotNil(story.category, @"story.category is nil");
//    XCTAssertNotNil(story.open, @"story.open is nil");
//    XCTAssertNotNil(story.storySnippets, @"story.storySnippets is nil");
//    XCTAssertNotNil(story.storySnippetCount, @"storySnippetCount is nil");
//    XCTAssertNotNil(story.pendingSnippets, @"story.pendingSnippets is nil");
//    XCTAssertNotNil(story.pendingSnippetCount, @"story.pendingSnippetCount is nil");
//    XCTAssertNotNil(story.storyID, @"story.storyID is nil");
//}

+ (void)testSampleUser {
    id usersArray = [API sampleUser];
    User *user = usersArray[0];
    XCTAssert([usersArray isKindOfClass:[NSMutableArray class]], @"usersArray is not an instance of NSMutableArray");
    XCTAssertFalse([usersArray isEmpty], @"users is empty");
    XCTAssert([usersArray[0] isKindOfClass:[User class]], @"user is not of class User");
    XCTAssertNotNil(user.userName, @"user.userName is nil");
    XCTAssertNotNil(user.password, @"user.password is nil");
    XCTAssertNotNil(user.email, @"user.email is nil");
    XCTAssertNotNil(user.ownedStories, @"user.ownedStories is nil");
    XCTAssertNotNil(user.followedStories, @"user.followedStories is nil");
    XCTAssertNotNil(user.userID, @"user.userID is nil");
    
}

//+ (void)testSampleSnippet {
//    id snippetsArray = [API sampleSnippet];
//    Snippet *snippet = snippetsArray[0];
//    XCTAssert([snippetsArray isKindOfClass:[NSMutableArray class]], @"snippetsArray is not an instance of NSMutableArray");
//    XCTAssertFalse([snippetsArray isEmpty], @"snippetsArray is empty");
//    XCTAssert([snippetsArray[0] isKindOfClass:[Snippet class]], @"snippet is not of class Snippet");
//    XCTAssertNotNil(snippet.likes, @" is nil");
//    XCTAssertNotNil(snippet.content, @" is nil");
//    XCTAssertNotNil(snippet.createdDate, @" is nil");
//    XCTAssertNotNil(snippet.snippetCreator, @" is nil");
//    XCTAssertNotNil(snippet.pending, @" is nil");
//    XCTAssertNotNil(snippet.snippetID, @" is nil");
//    XCTAssertNotNil(snippet.accepted, @" is nil");
//    XCTAssertNotNil(snippet.acceptedDate, @" is nil");
//    XCTAssertNotNil(snippet.lastViewDate, @" is nil");
//    XCTAssertNotNil(snippet.bookmark, @" is nil");
//    
//}

+ (void)testFetchAllStories {
    NSArray<Story *> *controlArray = [[NSArray alloc]init];
    [API fetchAllStories:^(NSArray<Story *> *allStories) {
        XCTAssertFalse([allStories isEqualToArray:controlArray], @"allStories array is empty!");
        for (Story *story in allStories) {
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
    }];
}

+ (void)testFetchSnippets {
    __block NSString *testStoryID = [[NSString alloc]init];
    [API fetchAllStories:^(NSArray<Story *> *allStories) {
        testStoryID = allStories[0].storyID;
    }];
    [API fetchSnippets:^(NSArray<Snippet *> *allSnippets) {
        NSArray<Snippet *> *controlArray = [[NSArray alloc]init];
        XCTAssertFalse([allSnippets isEqualToArray:controlArray], @"allSnippets array is empty!");
        for (Snippet *snippet in allSnippets) {
            XCTAssertNotNil(snippet.likes, @"snippet.likes is nil");
            XCTAssertNotNil(snippet.content, @"snippet.content is nil");
            XCTAssertNotNil(snippet.createdDate, @"snippet.createdDate is nil");
            XCTAssertNotNil(snippet.snippetCreator, @"snippetCreator is nil");
            XCTAssertNotNil(snippet.pending, @"snippet.pending is nil");
            XCTAssertNotNil(snippet.snippetID, @"snippet.snippetID is nil");
            XCTAssertNotNil(snippet.accepted, @"snippet.accept is nil");
            XCTAssertNotNil(snippet.acceptedDate, @"snippet.acceptedDate is nil");
            XCTAssertNotNil(snippet.lastViewDate, @"snippet.lastViewDate is nil");
            XCTAssertNotNil(snippet.bookmark, @"snippet.bookmark is nil");
        }
    } With:testStoryID];
}

+ (void)testPostSnippetFor {
    
}

+ (void)testFetchUser {
    
}

@end
