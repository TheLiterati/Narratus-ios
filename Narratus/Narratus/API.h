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
typedef void(^FetchUserCompletion)(User *loggedInUser);
//typedef void(^FetchStoriesCompletion)(NSArray<Story *> *stories);

typedef void(^loginCompletion)(NSArray*);


@interface API : NSObject


//@property(strong, nonatomic) NSMutableArray<User *> *allUsers;
//@property(strong, nonatomic) NSMutableArray<Snippet *> *allSnippets;

//+(void)sampleStory;
+(NSMutableArray *)sampleStory;

+(NSMutableArray *)sampleUser;

+(NSMutableArray *)sampleSnippet;

//homeView controller

+(void)fetchAllStories:(FetchAllStoriesCompletion)completion;

//storyView controller
//-(NSArray<Snippet *> *)fetchSnippetsFrom:(NSString *)storyID;
//-(Snippet*)postSnippet:(Snippet*)snippet;
+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID;
+(void)postSnippetFor:(NSString *)storyID with:(NSString *)snippetContent;

//ownedStory
//-(Snippet*)pendingToConfirmed:(Snippet*)pendingSnippet;
//
//-(Story*)closeStory:(Story*)openStory;
//
//newStory
//-(Story*)createStory:(Story*)newStoryWith:(NSString*)userID;
+(void)postNewStory;

//user dashboard
+(void)fetchUser:(FetchUserCompletion)completion;
//+(void)fetchStories:(FetchStoriesCompletion)completion With:(NSArray *)storyIDs;


@end
