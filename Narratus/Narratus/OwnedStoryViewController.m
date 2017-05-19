//
//  OwnedStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedStoryViewController.h"
#import "API.h"
#import "OwnedStorySnippetViewController.h"
#import "PendingSnippetViewController.h"

@interface OwnedStoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *openCloseButton;

@end

@implementation OwnedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buttonHandler];
    NSLog(@"%@", self.currentStory);
    self.titleLabel.text = self.currentStory.title;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [API pendingtoConfirmedFor:self.currentStory.storyID withCompletion:^(NSArray<Snippet *> *confirmedSnippets, NSArray<Snippet *> *pendingSnippets) {
        OwnedStorySnippetViewController *ownedSnippetVC = self.childViewControllers[0];
        ownedSnippetVC.confirmedSnippets = confirmedSnippets;
        
        PendingSnippetViewController *pendingSnippetVC = self.childViewControllers[1];
        pendingSnippetVC.pendingSnippets = pendingSnippets;
    }];
}


- (void) buttonHandler {
    if ([_currentStory.open isEqual:@"true"]) {
        self.openCloseButton.titleLabel.text = @"Close story";
    } else {
        self.openCloseButton.titleLabel.text = @"Open story";
    }
}

- (IBAction)closedButtonPressed:(UIButton *)sender {
    if ([_currentStory.open isEqual: @"true"]) {
        _currentStory.open = @"false";
    } else if ([_currentStory.open isEqual: @"false"]) {
        _currentStory.open = @"true";
    }
    // Send to server
    [self buttonHandler];
}


@end
