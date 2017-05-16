//
//  UserDashboardViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "UserDashboardViewController.h"
#import "OwnedTableViewController.h"
#import "FollowedStoryViewController.h"


@interface UserDashboardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation UserDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.userNameLabel.text = @"username here please";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self checkUser];
}

-(void)checkUser {
    if (!self.user) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}

@end
