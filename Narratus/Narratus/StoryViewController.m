//
//  StoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryViewController.h"


@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UIView *storyTableView;
@property (weak, nonatomic) IBOutlet UIView *addSnippetView;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
//@property (strong, nonatomic) NSArray<Snippet*> *allSnippets;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.currentStory.pendingSnippets count] == 10) {
        self.toggleButton.hidden = YES;
    }
    if ([self.currentStory.storySnippets lastObject]) {
        //If user of last object is same as logged-in user
        self.toggleButton.hidden = YES;
    }
    // if (!logged in user) {
//    self.toggleButton.hidden = YES;

}


- (IBAction)toggleSnippetView:(id)sender {
    if (self.addSnippetView.hidden == YES) {
        self.addSnippetView.hidden = NO;
    }
}


@end
