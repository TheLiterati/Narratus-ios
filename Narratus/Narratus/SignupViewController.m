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
    
}

-(void)signup{
    
    NSString* urlString = [NSString stringWithFormat:@"https://narratus-staging.herokuapp.com/api/signup?username=%@&email=%@&password=%@", self.userNameTextField.text, self.emailTextField.text, self.passwordTextField.text];
    
    NSURL *databaseuRL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [session dataTaskWithURL:databaseuRL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *tokenDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        
    }];
    
}


@end
