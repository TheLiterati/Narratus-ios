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
@property (strong, nonatomic) NSString *createdDate;
@property (strong, nonatomic) NSString *snippetCreator;
@property (strong, nonatomic) NSString *pending;
@property (strong, nonatomic) NSString *snippetID;
@property (strong, nonatomic) NSString *accepted;
@property (strong, nonatomic) NSDate *acceptedDate;
@property (strong, nonatomic) NSDate *lastViewDate;
@property (strong, nonatomic) NSString *bookmark;

@end
