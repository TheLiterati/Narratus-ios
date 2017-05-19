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
            
            if ([story.storySnippets count] > 0) {
                for (Snippet *snippet in story.pendingSnippets) {
                    XCTAssertNotNil(snippet.createdDate, @"snippet.createdDate is not nil");
                    XCTAssertNotNil(snippet.pending, @"snippet.pending is not nil");
                    XCTAssertNotNil(snippet.snippetID, @"snippet.snippetID is not nil");
                    XCTAssertNotNil(snippet. @"snippet. is not nil");
                    XCTAssertNotNil(snippet. @"snippet. is not nil");
                    XCTAssertNotNil(snippet. @"snippet. is not nil");
                }
            }
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



@end
