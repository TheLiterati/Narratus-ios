//
//  User.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSArray *ownedStories;
@property (strong, nonatomic) NSArray *followedStories;
@property (strong, nonatomic) NSString *userID;




@end
