//
//  FollowedStoryViewController.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface FollowedStoryViewController : UIViewController
@property(strong, nonatomic) NSArray<Story *> *followedStories;

@end
