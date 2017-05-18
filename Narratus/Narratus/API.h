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

+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID; //give id get story object with [snippet objects];
+(void)postSnippetFor:(NSString *)storyID with:(NSString *)snippetContent;

//ownedStory
//-(Snippet*)pendingToConfirmed:(Snippet*)pendingSnippet;
//-(Story*)closeStory:(Story*)openStory;
+(void)pendingtoConfirmedFor:(NSString *)storyID with:(NSString *)content;

//newStory
//-(Story*)createStory:(Story*)newStoryWith:(NSString*)userID;
+(void)postNewStoryWith:(NSString *)title with:(NSString *)description with:(NSString *)genre and:(NSString *)startSnippet;

//user dashboard
//+(void)fetchStories:(FetchStoriesCompletion)completion With:(NSArray *)storyIDs;
+(void)fetchUser:(FetchUserCompletion)completion;



@end
