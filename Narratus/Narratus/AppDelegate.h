//
//  AppDelegate.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GoogleSignIn/GoogleSignIn.h>
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

