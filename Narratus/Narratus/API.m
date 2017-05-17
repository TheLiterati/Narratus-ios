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

+(void)fetchAllStories:(FetchAllStoriesCompletion)completion {
    NSLog(@"inside fetch stories");
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/story/"];
    
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
        NSMutableArray *allStories = [[NSMutableArray alloc]init];
        
        for (NSDictionary *story in [rootObject allValues]) {
            NSLog(@"title: %@", story[@"title"]);
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
        
        if (completion) {
          [[NSOperationQueue mainQueue]addOperationWithBlock:^{
              completion(allStories);
          }];
        }
    }]resume];
}

+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID{
    NSLog(@"inside fetch snippets");
    //check url
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/story/%@", storyID];
    
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
        NSMutableArray *allSnippets = [[NSMutableArray alloc]init];
        
        for (NSDictionary *snippet in [rootObject allValues]) {
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
        
        if (completion) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                completion(allSnippets);
            }];
        }
    }]resume];
}

+(void)postSnippetFor:(NSString *)storyID with:(NSString *)snippetContent {
    NSLog(@"inside post snippet");
    //check url
    NSString *token = @"test token";
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/snippet/%@ snippetContent=%@ 'Authorization:Bearer %@", storyID, snippetContent, token]; //check token
    
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
    }];
}

@end
















