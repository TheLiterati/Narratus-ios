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
#import "HomeViewController.h"
#import "LoginViewController.h"

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

- (IBAction)logoutPressed:(UIBarButtonItem *)sender {
    self.user = nil;
    
    //this is creating a separate, new instance of the Homeiew controller, not workable with the UI flow
//    HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
//    LoginViewController *loginVC = [self.navigationController popToViewController:@"LoginViewController" animated:YES:];
    
//    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
