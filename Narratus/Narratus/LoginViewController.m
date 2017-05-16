//
//  LoginViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "LoginViewController.h"
@import GoogleSignIn;
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    GIDSignInButton *googleSignIn = [[GIDSignInButton alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
    [self.view addSubview:googleSignIn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(UIButton *)sender {
    
    
}
- (IBAction)signupPressed:(UIButton *)sender {
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

@end
