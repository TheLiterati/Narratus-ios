//
//  SignupViewController.h
//  Narratus
//
//  Created by Christina Lee on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SignupCompletion)(NSString* token);
@protocol toggleSignUpProtocol <NSObject>

-(void)passBackData:(BOOL)status;

@end


@interface SignupViewController : UIViewController

@property(nonatomic, assign)id delegate;


@end
