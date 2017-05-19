//
//  UserDashboardViewController.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "LoginViewController.h"
#import "Story.h"

@interface UserDashboardViewController : UIViewController

@property(strong, nonatomic) User *user;
@property (strong, nonatomic) Story *selectedStory;

@end
