//
//  LoginViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signupHeight;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIView *signupView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)loginPressed:(UIButton *)sender {
    [self login];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)signupPressed:(UIButton *)sender {
    self.signupView.hidden = NO;
    self.signupHeight.constant = 275;
    [UIView animateWithDuration:0.6 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    self.signupButton.hidden = YES;
}

-(void)login {
    
    NSString *urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/signin"];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *authString = [NSString stringWithFormat:@"%@:%@", self.usernameTextField.text, self.passwordTextField.text];
    NSData *authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    
//    [request setValue:@"%@", self.usernameTextField.text forHTTPHeaderField:@"username"];
//    [request setValue:@"%@", self.passwordTextField.text forHTTPHeaderField:@"password"];
    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Auth"] forHTTPHeaderField:@"Authorization"];
    
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", response);
        
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        if (data) {
            
            // Your file writing code here
            NSLog(@"%@", data);
        }
        
    }] resume];
    
    
    
}






@end
