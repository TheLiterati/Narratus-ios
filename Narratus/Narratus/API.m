//
//  API.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "API.h"
#import "StoryManager.h"

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
    
    NSMutableDictionary *snippetDictionary = [[NSMutableDictionary alloc]init];
    snippetDictionary[@"storyID"] = storyID;
    snippetDictionary[@"snippetContent"] = snippetContent;
    
    NSError *dataError;
    
    NSData *snippetData = [NSJSONSerialization dataWithJSONObject:snippetDictionary options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    
    request.HTTPMethod = @"POST";
    [request setHTTPBody:snippetData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *dataString = [[NSString alloc]initWithData:snippetData encoding:NSUTF8StringEncoding];
        
        NSLog(@"request response: %@", response);
        NSLog(@"request data: %@", data);
        
    }] resume];
}

+(void)fetchUser:(FetchUserCompletion)completion {
    NSLog(@"inside fetch user");
    
    //retreive token
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    NSLog(@"TOKEN: %@", token);
    
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/dashboard"];
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"GET";
    
    //Removing quotes from the token for when passing as a header in GET requests
    NSUInteger charCount = [token length];
    NSRange oneToAccount = NSMakeRange(1, charCount - 2);
    
    //Pure token, no quotes
    NSString *tokenWork = [token substringWithRange:oneToAccount];
    NSLog(@"%@", tokenWork);
    
    NSString *bearAuth = [NSString stringWithFormat:@"Bearer %@", tokenWork];
    [request setValue:bearAuth forHTTPHeaderField:@"Authorization:"];
  
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
   
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
        User *currentUser = [[User alloc]init];
        
        for (NSDictionary *user in [rootObject allValues]) {
            NSMutableArray<Story *> *owned = [[NSMutableArray<Story *> alloc]init];
            NSMutableArray<Story *> *followed = [[NSMutableArray<Story *> alloc]init];
            
            User *newUser = [[User alloc]init];
            newUser.userName = user[@"username"];
            newUser.password = user[@"password"];
            newUser.email = user[@"email"];
            newUser.userID = user[@"_id"];
            
            for (NSDictionary *story in user[@"ownedStories"]) {
                NSMutableArray<Snippet *> *storySnippets = [[NSMutableArray alloc]init];
                NSMutableArray<Snippet *> *pendingSnippets = [[NSMutableArray alloc]init];
                
                Story *newStory = [[Story alloc]init];
                newStory.ownerUserName = story[@"ownerUsername"];
                newStory.ownerID = story[@"ownerId"];
                newStory.title = story[@"title"];
                newStory.storyDescription = story[@"description"];
                newStory.createdDate = story[@"created"];
                newStory.lastUpdatedDate = story[@"lastUpdated"];
                newStory.category = story[@"categories"];
                newStory.open = story[@"open"];
                newStory.storySnippetCount = story[@"snippetCount"];
                newStory.pendingSnippetCount = story[@"pendingSnippetCount"];
                newStory.storyID = story[@"_id"];
                
                for (NSDictionary *snippet in story[@"snippets"]) {
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
                    
                    [storySnippets addObject:newSnippet];
                }
                
                for (NSDictionary *snippet in story[@"pendingSnippets"]) {
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
                    
                    [pendingSnippets addObject:newSnippet];
                }
                
                newStory.storySnippets = storySnippets;
                newStory.pendingSnippets = pendingSnippets;
                
                [owned addObject:newStory];
            }
            
            for (NSDictionary *story in user[@"followedStories"]) {
                NSMutableArray<Snippet *> *storySnippets = [[NSMutableArray alloc]init];
                NSMutableArray<Snippet *> *pendingSnippets = [[NSMutableArray alloc]init];
                
                Story *newStory = [[Story alloc]init];
                newStory.ownerUserName = story[@"ownerUsername"];
                newStory.ownerID = story[@"ownerId"];
                newStory.title = story[@"title"];
                newStory.storyDescription = story[@"description"];
                newStory.createdDate = story[@"created"];
                newStory.lastUpdatedDate = story[@"lastUpdated"];
                newStory.category = story[@"categories"];
                newStory.open = story[@"open"];
                newStory.storySnippetCount = story[@"snippetCount"];
                newStory.pendingSnippetCount = story[@"pendingSnippetCount"];
                newStory.storyID = story[@"_id"];
                
                for (NSDictionary *snippet in story[@"snippets"]) {
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
                    
                    [storySnippets addObject:newSnippet];
                }
                
                for (NSDictionary *snippet in story[@"pendingSnippets"]) {
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
                    
                    [pendingSnippets addObject:newSnippet];
                }
                
                newStory.storySnippets = storySnippets;
                newStory.pendingSnippets = pendingSnippets;
                
                [followed addObject:newStory];
            }
            
            newUser.ownedStories = owned;
            newUser.followedStories = followed;
            
            
            currentUser = newUser;
        }
        
        if (completion) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                completion(currentUser);
            }];
        }
    }]resume];
}

+(void)postNewStoryWith:(NSString *)title with:(NSString *)description with:(NSString *)genre and:(NSString *)startSnippet {
    NSLog(@"inside post story");
    
    //Retreive token
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    
    //Base URL
    NSURL *databaseURL =[NSURL URLWithString:@"https://narratus-staging.herokuapp.com/api/story"];
    

    
    //Removing quotes from the token for when passing as a header in GET requests
    NSUInteger charCount = [token length];
    NSRange oneToAccount = NSMakeRange(1, charCount - 2);
    
    //Pure token, no quotes
    NSString *tokenWork = [token substringWithRange:oneToAccount];
    NSLog(@"%@", tokenWork);
    
    //Title and description strings for reference to be able to pass into story string
    NSString *titleString = [[NSString alloc]initWithString:title];
    NSString *descriptionString = [[NSString alloc]initWithString:description];
   
    //Request string
    NSString *requestString = [NSString stringWithFormat:@"&title=%@&description=%@&Authorization:Bearer %@",titleString, descriptionString,tokenWork];

    //Request data
    NSError *dataError;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestString options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }
    
    
    //Create the request of type POST, set body
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"POST";
    [request setHTTPBody:requestData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSMutableDictionary *storyDictionary = [[NSMutableDictionary alloc]init];
    storyDictionary[@"title"] = titleString;
    storyDictionary[@"description"] = descriptionString;
    storyDictionary[@"genre"] = genre;
    storyDictionary[@"startSnippet"] = startSnippet;
    
    //Need to pass title, description data into 
    [StoryManager.shared userStories];
    
    NSLog(@"Story string: %@", requestString);
    
    //Start the session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];

    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        NSString *dataString = [[NSString alloc]initWithData:snippetData encoding:NSUTF8StringEncoding];
        
        NSLog(@"request response: %@", response);
        NSLog(@"request data: %@", data);
        
    }] resume];
}

+(void)pendingtoConfirmedFor:(NSString *)storyID with:(NSString *)content {
    NSLog(@"inside pending to confirmed");
    //check url
    NSString *token = @"test token";
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/story/ %@ %@ %@", storyID, content, token]; //check token
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSMutableDictionary *confirmedSnippet = [[NSMutableDictionary alloc]init];
    confirmedSnippet[@"storyID"] = storyID;
    confirmedSnippet[@"content"] = content;
    
    NSError *dataError;
    
    NSData *snippetData = [NSJSONSerialization dataWithJSONObject:confirmedSnippet options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    
    request.HTTPMethod =@"PUT";
    [request setHTTPBody:snippetData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"request response: %@", response);
        NSLog(@"request data: %@", data);
    }] resume];
}


@end












