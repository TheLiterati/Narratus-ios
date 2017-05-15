//
//  Snippet.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Snippet : NSObject

@property (strong, nonatomic) NSNumber *likes;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) User *snippetCreator;
@property (nonatomic) BOOL *pending;
@property (strong, nonatomic) NSString *snippetID;
@property (nonatomic) BOOL *accepted;
@property (strong, nonatomic) NSDate *acceptedDate;
@property (strong, nonatomic) NSDate *lastViewDate;
@property (nonatomic) BOOL *bookmark;

@end
