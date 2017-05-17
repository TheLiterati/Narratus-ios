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

@interface API : NSObject


//@property(strong, nonatomic) NSMutableArray<User *> *allUsers;
//@property(strong, nonatomic) NSMutableArray<Snippet *> *allSnippets;

//+(void)sampleStory;
+(NSMutableArray *)sampleStory;

+(NSMutableArray *)sampleUser;

+(NSMutableArray *)sampleSnippet;

//homeView controller
//-(NSArray*)fetchAllStories;
+(void)fetchAllStories:(FetchAllStoriesCompletion)completion;

//storyView controller
-(NSArray<Snippet *> *)fetchSnippetsFrom:(NSString *)storyID;
//-(Snippet*)postSnippet:(Snippet*)snippet;
+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID;
+(void)postSnippetFor:(NSString *)storyID with:(NSString *)snippetContent;

////ownedStory
//-(Snippet*)pendingToConfirmed:(Snippet*)pendingSnippet;
//
//-(Story*)closeStory:(Story*)openStory;
//
////newStory
//-(Story*)createStory:(Story*)newStoryWith:(NSString*)userID;
//




@end
