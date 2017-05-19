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
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signup{
    NSLog(@"The token:");
    
    NSURL *databaseURL = [NSURL URLWithString:@"https://narratus-production.herokuapp.com/api/signup"];
    
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc]init];
    
    NSLog(@"%@",self.userNameTextField.text);
    NSLog(@"%@",self.emailTextField.text);
    NSLog(@"%@",self.passwordTextField.text);
    
    userDictionary[@"username"] = self.userNameTextField.text;
    userDictionary[@"email"] = self.emailTextField.text;
    userDictionary[@"password"] = self.passwordTextField.text;

    NSError *dataError;
    
    NSData *userData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error:&dataError];
    
    if (dataError) {
        NSLog(@"%@", dataError.localizedDescription);
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:databaseURL];
    
    request.HTTPMethod = @"POST";
    [request setHTTPBody:userData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"request response: %@", response);
        NSLog(@"request data: %@", data);
        
        NSString *token = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", token);

        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"accessToken"];
        
        if (data != nil) {
            NSLog(@"%@", data);
            NSString *token = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", token);
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"signupAccessToken"];
            
        }
        
//        if (completion) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                completion(token);
//                
//            });
//        }
        
    }] resume];
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
