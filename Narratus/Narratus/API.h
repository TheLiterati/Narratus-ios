//
//  API.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "User.h"
#import "Snippet.h"


typedef void(^FetchAllStoriesCompletion)(NSArray<Story *> *allStories);
typedef void(^FetchAllSnippetsCompletion)(NSArray<Snippet *> *allSnippets);

typedef void(^UserCompletion)(NSArray<Story *> *followedStories, NSArray<Story *> *ownedStories);

typedef void(^loginCompletion)(NSArray*);


@interface API : NSObject


+(NSMutableArray *)sampleStory;

+(NSMutableArray *)sampleUser;

+(NSMutableArray *)sampleSnippet;

//homeView controller
+(void)fetchAllStories:(FetchAllStoriesCompletion)completion;

//storyView controller
+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID; //give id get story object with [snippet objects];
+(void)postSnippetFor:(NSString *)storyID with:(NSString *)snippetContent;

//ownedStory
//-(Story*)closeStory:(Story*)openStory;
+(void)pendingtoConfirmedFor:(NSString *)content;
+(void)closeStoryFor:(NSString *)storyID;

//newStory
+(void)postNewStoryWith:(NSString *)title with:(NSString *)description and:(NSString *)startSnippet;


//user dashboard
+(void)fetchUser:(UserCompletion)completion;



@end
