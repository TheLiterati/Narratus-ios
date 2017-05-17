//
//  SignupViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupButtonPressed:(UIButton *)sender {
    [self signup];
}

-(void)signup{
    NSLog(@"The token:");
    
    NSString* urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/signup?"];
    NSURL *databaseuRL = [NSURL URLWithString:urlString];
    
     NSString *bodyURL = [NSString stringWithFormat:@"username=%@&email=%@&password=%@", self.userNameTextField.text, self.emailTextField.text, self.passwordTextField.text];
    NSData *bodyData = [NSData dataWithContentsOfFile:bodyURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseuRL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseuRL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"request response: %@", response);
        NSLog(@"request data: %@", data);
        
//        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"accessToken"];
        
//        if (data != nil) {
//            NSLog(@"%@", data);
////            NSString *token = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@", token);
////            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"accessToken"];
//            
//        }
        
//        if (completion) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                completion(token);
//                
//            });
//        }
        
    }] resume];
}

@end
