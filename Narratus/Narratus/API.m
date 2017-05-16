//
//  API.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "API.h"


@implementation API

+(NSMutableArray *)sampleStory {
    NSMutableArray<Story *> *allStories = [[NSMutableArray<Story *> alloc]init];
    NSDictionary *stories = [[NSDictionary alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"storysample" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSError *jsonError;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError) {
        NSLog(@"sample error: %@", jsonError.localizedDescription);
    }
    
    stories = jsonDictionary[@"Stories"];
    
    for (NSDictionary *story in stories) {
        Story *newStory = [[Story alloc]init];
        newStory.ownerUserName = story[@"ownerUsername"];
        newStory.ownerID = story[@"ownerId"];
        newStory.title = story[@"title"];
        newStory.storyDescription = story[@"description"];
        newStory.createdDate = story[@"created"];
        newStory.lastUpdatedDate = story[@"lastUpdated"];
        newStory.category = story[@"categories"];
        newStory.open = story[@"open"];
        newStory.storySnippets = story[@"snippets"];
        newStory.storySnippetCount = story[@"snippetCount"];
        newStory.pendingSnippets = story[@"pendingSnippets"];
        newStory.pendingSnippetCount = story[@"pendingSnippetCount"];
        newStory.storyID = story[@"_id"];
    
        [allStories addObject:newStory];
    }
    return allStories;
}

+(NSMutableArray *)sampleUser {
    NSMutableArray<User *> *allUsers = [[NSMutableArray<User *> alloc]init];
    NSDictionary *users = [[NSDictionary alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"usersample" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSError *jsonError;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError) {
        NSLog(@"%@", jsonError.localizedDescription);
    }
    
    users = jsonDictionary[@"Users"];
    
    for (NSDictionary *user in users) {
        User *newUser = [[User alloc]init];
        newUser.userName = user[@"username"];
        newUser.password = user[@"password"];
        newUser.email = user[@"email"];
        newUser.ownedStories = user[@"ownedStories"];
        newUser.followedStories = user[@"followedStories"];
        newUser.userID = user[@"_id"];
        
        [allUsers addObject:newUser];
    }
    return allUsers;
}

+(NSMutableArray *)sampleSnippet {
    NSMutableArray<Snippet *> *allSnippets = [[NSMutableArray<Snippet *> alloc]init];
    NSDictionary *snippets = [[NSDictionary alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"snippetsample" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSError *jsonError;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError) {
        NSLog(@"%@", jsonError.localizedDescription);
    }
    
    snippets = jsonDictionary[@"Snippets"];
    
    for (NSDictionary *snippet in snippets) {
        Snippet *newSnippet = [[Snippet alloc]init];
        newSnippet.likes = snippet[@"likes"];
        newSnippet.content = snippet[@"snippetContent"];
        newSnippet.createdDate = snippet[@"created"];
        newSnippet.snippetCreator = snippet[@"snippetCreator"];
        newSnippet.pending = snippet[@"pending"];
        newSnippet.snippetID = snippet[@"_id"];
        newSnippet.accepted = snippet[@"accepted"];
        newSnippet.acceptedDate = snippet[@"acceptedDate"];
        newSnippet.lastViewDate = snippet[@"lastViewedDate"];
        newSnippet.bookmark = snippet[@"bookmark"];
        
        [allSnippets addObject:newSnippet];
    }
    return allSnippets;
}
@end
















