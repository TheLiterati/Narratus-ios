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
#import "API.h"


@interface UserDashboardViewController () 

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation UserDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userNameLabel.text = self.user.userName;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self checkUser];
}

-(void)checkUser {
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    
    if (token) {
        [API fetchUser:^(NSArray<Story *> *followedStories, NSArray<Story *> *ownedStories) {
            OwnedTableViewController *childOwnedVC = self.childViewControllers[0];
            childOwnedVC.ownedStories = [ownedStories mutableCopy];
            
            FollowedStoryViewController *childFollowedVC = self.childViewControllers[1];
            childFollowedVC.followedStories = [followedStories mutableCopy];
        }];
    } else {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }
}

//StoryViewController *parent = [self parentViewController];
//self.selectedStory = parent.currentStory;


- (IBAction)logoutPressed:(UIBarButtonItem *)sender {
    self.user = nil;
    

//    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"accessToken"];
//
//    //this is creating a separate, new instance of the Homeiew controller, not workable with the UI flow
//    HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    
// //   LoginViewController *loginVC = [self.navigationController popToViewController:@"LoginViewController" animated:YES:];

//    LoginViewController *login = [self.navigationController popViewControllerAnimated:@"LoginViewController"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:login animated:YES completion:nil];
}

@end
