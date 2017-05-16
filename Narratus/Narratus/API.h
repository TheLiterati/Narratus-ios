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


@interface API : NSObject


@property(strong, nonatomic) NSMutableArray<User *> *allUsers;
@property(strong, nonatomic) NSMutableArray<Snippet *> *allSnippets;

//+(void)sampleStory;
+(NSMutableArray *)sampleStory;
-(void)sampleUser;

-(void)sampleSnippet;

@end
