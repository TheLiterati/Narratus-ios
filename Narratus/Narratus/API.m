
//  API.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "API.h"
#import "Story.h"

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
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"root object: %@", rootObject);
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
        NSMutableArray *allStories = [[NSMutableArray alloc]init];
        
        for (NSDictionary *story in rootObject) {
            NSLog(@"title: %@", story[@"title"]);
            
            NSMutableArray<Snippet *> *storySnippets = [[NSMutableArray alloc]init];
            NSMutableArray<Snippet *> *pendingSnippets = [[NSMutableArray alloc]init];
            
            Story *newStory = [[Story alloc]init];
            NSLog(@"story content: %@", story);
            newStory.ownerUserName = story[@"ownerUsername"];
            newStory.title = story[@"title"];
            newStory.storyDescription = story[@"description"];
            newStory.createdDate = story[@"created"];
            newStory.category = story[@"genre"];
            newStory.open = story[@"open"];
            newStory.storySnippetCount = story[@"snippetCount"];
            newStory.pendingSnippetCount = story[@"pendingSnippetCount"];
            newStory.storyID = story[@"_id"];
            newStory.startSnippet = story[@"startSnippet"];
            
            NSLog(@"%@, %@", newStory.startSnippet, newStory.ownerUserName);
            
            if (story[@"SnippetCount"] > 0) {
                for (NSDictionary *snippet in story[@"snippets"]) {
                    Snippet *newSnippet = [[Snippet alloc]init];
                    newSnippet.createdDate = snippet[@"created"];
                    newSnippet.pending = snippet[@"pending"];
                    newSnippet.snippetID = snippet[@"_id"];
                    newSnippet.acceptedDate = snippet[@"approvedDate"];
                    newSnippet.lastViewDate = snippet[@"lastViewDate"];
                    newSnippet.content = snippet[@"snippetContent"];
                    
                    [storySnippets addObject:newSnippet];

                }
            }
            
            if (story[@"pendingSnippetCount"] > 0) {
                for (NSDictionary *snippet in story[@"pendingSnippets"]) {
                    Snippet *newSnippet = [[Snippet alloc]init];
                    newSnippet.createdDate = snippet[@"created"];
                    newSnippet.pending = snippet[@"pending"];
                    newSnippet.snippetID = snippet[@"_id"];
                    newSnippet.acceptedDate = snippet[@"approvedDate"];
                    newSnippet.lastViewDate = snippet[@"lastViewDate"];
                    newSnippet.content = snippet[@"snippetContent"];
                    
                    [pendingSnippets addObject:newSnippet];
                }
                newStory.pendingSnippets = pendingSnippets;
            }

            newStory.storySnippets = storySnippets;

            [allStories addObject:newStory];
        }
        
        if (completion) {
          [[NSOperationQueue mainQueue]addOperationWithBlock:^{
              completion(allStories);
          }];
        }
    }]resume];
}

+(void)fetchSnippets:(FetchAllSnippetsCompletion)completion With:(NSString *)storyID {
    NSLog(@"inside fetch snippets");

    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/story/%@", storyID];
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    
    NSError *dataError;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"GET";

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
     [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         NSLog(@"data:%@", data);
         NSLog(@"response:%@", response);
         NSDictionary *story = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSLog(@"root object: %@", story);
         
         if (error) {
             NSLog(@"error: %@",error.localizedDescription);
         }
        
        NSMutableArray *allSnippets = [[NSMutableArray alloc]init];
        
        NSLog(@"TITLE: %@", story[@"title"]);
        if (story[@"SnippetCount"] > 0) {
            for (NSDictionary *snippet in story[@"snippets"]) {
                Snippet *newSnippet = [[Snippet alloc]init];
                newSnippet.createdDate = snippet[@"created"];
                newSnippet.pending = snippet[@"pending"];
                newSnippet.snippetID = snippet[@"_id"];
                newSnippet.acceptedDate = snippet[@"approvedDate"];
                newSnippet.lastViewDate = snippet[@"lastViewDate"];
                newSnippet.content = snippet[@"snippetContent"];
                 
                [allSnippets addObject:newSnippet];
            }
        }
         
//         for (NSDictionary *story in rootObject) {
         
             
//             NSMutableArray<Snippet *> *storySnippets = [[NSMutableArray alloc]init];

//             Story *newStory = [[Story alloc]init];
//             NSLog(@"story content: %@", story);
//             newStory.ownerUserName = story[@"ownerUsername"];
//             newStory.title = story[@"title"];
//             newStory.storyDescription = story[@"description"];
//             newStory.createdDate = story[@"created"];
//             newStory.category = story[@"genre"];
//             newStory.open = story[@"open"];
//             newStory.storySnippetCount = story[@"snippetCount"];
//             newStory.pendingSnippetCount = story[@"pendingSnippetCount"];
//             newStory.storyID = story[@"_id"];
//             newStory.startSnippet = story[@"startSnippet"];
             
//             if (story[@"SnippetCount"] > 0) {
//                 for (NSDictionary *snippet in story[@"snippets"]) {
//                     Snippet *newSnippet = [[Snippet alloc]init];
//                     newSnippet.createdDate = snippet[@"created"];
//                     newSnippet.pending = snippet[@"pending"];
//                     newSnippet.snippetID = snippet[@"_id"];
//                     newSnippet.acceptedDate = snippet[@"approvedDate"];
//                     newSnippet.lastViewDate = snippet[@"lastViewDate"];
//                     newSnippet.content = snippet[@"snippetContent"];
//                     
//                     [allSnippets addObject:newSnippet];
//                 }
//             } 
//         }
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
    
     NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/snippet/%@ snippetContent=%@", storyID, snippetContent]; 
    
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
    
    NSUInteger charCount = [token length];
    NSRange oneToAccount = NSMakeRange(1, charCount - 2);
    NSString *tokenWork = [token substringWithRange:oneToAccount];
   // NSLog(@"realToken: %@", tokenWork);
    
    NSString *bearAuth = [NSString stringWithFormat:@"Bearer %@", tokenWork];
    [request addValue:bearAuth forHTTPHeaderField:@"Authorization"];
    NSLog(@"BEARAUTH: %@", bearAuth);

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *dataString = [[NSString alloc]initWithData:snippetData encoding:NSUTF8StringEncoding];
        
        NSLog(@"request response: %@", response);
       // NSLog(@"request data: %@", data);
        
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"DATASTRING: %@",dataString);
        
    }] resume];
}

+(void)fetchUser{
    NSLog(@"inside fetch user");
    
    //retreive token
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    NSLog(@"%@", token);
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/dashboard"];
    NSURL *databaseURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"GET";
    
    //Removing quotes from the token for when passing as a header in GET requests
    NSUInteger charCount = [token length];
    NSRange oneToAccount = NSMakeRange(1, charCount - 2);
    
    //Pure token, no quotes
    NSString *tokenWork = [token substringWithRange:oneToAccount];
    NSLog(@"TOOKEEN: %@", tokenWork);
    
    NSString *bearAuth = [NSString stringWithFormat:@"Bearer %@", tokenWork];
    [request setValue:bearAuth forHTTPHeaderField:@"Authorization:"];
    NSLog(@"%@", bearAuth);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
   
        NSLog(@"data:%@", data);
        NSLog(@"response:%@", response);
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@s", rootObject);
        
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"DATASTRING: %@",dataString);
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
        }
        
        User *currentUser = [[User alloc]init];
        
        for (NSDictionary *items in [rootObject allValues]) {
            
            for (NSDictionary *stories in items[@"ownedStories"]) {
            
            Story *ownedStory = [[Story alloc]init];
            ownedStory.ownerID = stories[@"userID"];
            ownedStory.storyID = stories[@"_id"];
            ownedStory.title = stories[@"title"];
            ownedStory.storyDescription = stories[@"description"];
            ownedStory.category = stories[@"genre"];
            ownedStory.startSnippet = stories[@"startSnippet"];
            ownedStory.open = stories[@"open"];
            ownedStory.createdDate = stories[@"created"];
            ownedStory.genre = stories[@"genre"];
            }
            
            for (NSDictionary *stories in items[@"followedStories"]) {
                
            Story *followedStory = [[Story alloc] init];
            followedStory.ownerID = stories[@"userID"];
            followedStory.storyID = stories[@"_id"];
            followedStory.title = stories[@"title"];
            followedStory.storyDescription = stories[@"description"];
            //followedStory.category = stories[@"genre"];
            followedStory.startSnippet = stories[@"startSnippet"];
            followedStory.open = stories[@"open"];
            followedStory.createdDate = stories[@"created"];
            followedStory.genre = stories[@"genre"];
            }
            
        };
        
        
        
//        if (completion) {
//            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                completion(currentUser);
//            }];
//        }
    }]resume];
}

+(void)postNewStoryWith:(NSString *)title with:(NSString *)description and:(NSString *)startSnippet {
    
    NSLog(@"Inside post Story");
    
    //Retreive token
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    
    //Base URL
    NSURL *baseURL =[NSURL URLWithString:@"https://narratus-staging.herokuapp.com/api/story"];

    
    //Removing quotes from the token for when passing as a header in GET requests
    NSUInteger charCount = [token length];
    NSRange oneToAccount = NSMakeRange(1, charCount - 2);
    
    //Pure token, no quotes
    NSString *tokenWork = [token substringWithRange:oneToAccount];
    
    //Title and description strings for reference to be able to pass into request strings
    NSString *titleString = [[NSString alloc]initWithString:title];
    NSString *descriptionString = [[NSString alloc]initWithString:description];
    NSString *startSnippetString = [[NSString alloc]initWithString:startSnippet];
    
    NSMutableDictionary *storyDictionary = [[NSMutableDictionary alloc]init];
    storyDictionary[@"title"] = titleString;
    storyDictionary[@"description"] = descriptionString;
    storyDictionary[@"startSnippet"] = startSnippet;
   
    //Request string
    NSString *requestString = [NSString stringWithFormat:@"title=%@, description=%@, startSnippet=%@",titleString, descriptionString, startSnippetString];
     NSLog(@"%@", requestString);

    //Request data
    NSError *dataError;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:storyDictionary options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }
    
    //POST request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    request.HTTPMethod = @"POST";
    [request setHTTPBody:requestData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *bearAuth = [NSString stringWithFormat:@"Bearer %@", tokenWork];
    [request addValue:bearAuth forHTTPHeaderField:@"Authorization"];
    NSLog(@"%@", bearAuth);

    
    //Start the session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];

    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            NSString *parsedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"REQUEST DATA: %@", parsedData);
        }
        
         NSLog(@"RESPONSE: %@", response);
        
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

+(void)closeStoryFor:(NSString *)storyID{}

@end

//        for (NSDictionary *snippet in [rootObject allValues]) {
//            Snippet *newSnippet = [[Snippet alloc]init];
//            newSnippet.content = snippet[@"snippetContent"];
//            newSnippet.createdDate = snippet[@"created"];
//            newSnippet.pending = snippet[@"pending"];
//            newSnippet.snippetID = snippet[@"_id"];
//            newSnippet.accepted = snippet[@"approved"];
//            newSnippet.acceptedDate = snippet[@"approvedDate"];
//            newSnippet.lastViewDate = snippet[@"lastViewDate"];
//
//            [allSnippets addObject:newSnippet];
//        }










