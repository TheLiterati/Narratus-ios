//
//  Story.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Story : NSObject

@property (strong, nonatomic) NSArray<User *> *ownerUserName;
@property (strong, nonatomic) NSArray<User *> *ownerID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *storyDescription;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSDate *lastUpdatedDate;
@property (strong, nonatomic) NSString *category;
@property (nonatomic) BOOL *open;
@property (strong, nonatomic) NSArray *storySnippets;
@property (strong, nonatomic) NSNumber *storySnippetCount;
@property (strong, nonatomic) NSArray *pendingSnippets;
@property (strong, nonatomic) NSNumber *pendingSnippetCount;
@property (strong, nonatomic) NSString *storyID;



@end
