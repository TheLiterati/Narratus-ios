//
//  PendingSnippetViewController.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"
#import "Snippet.h"

@interface PendingSnippetViewController : UIViewController
@property (strong, nonatomic) Story *currentStory;
@property (strong, nonatomic) NSArray<Snippet *> *pendingSnippets;

@end
