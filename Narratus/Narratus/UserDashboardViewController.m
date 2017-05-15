//
//  UserDashboardViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "UserDashboardViewController.h"
#import "User.h"

@interface UserDashboardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property(strong, nonatomic) User *user;

@end

@implementation UserDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLabel.text = _user.ownedStories;
}



@end
