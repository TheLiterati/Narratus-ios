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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toggleButtonBottomConstraint;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *followButton;
@property (nonatomic) float hiddenConstant;
@property (nonatomic) float showConstant;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenConstant = 0.f;
    self.showConstant = 196;
    [self addSnippetHandler];
    [self followButtonHandler];

}

- (void)addSnippetHandler {
    if ([self.currentStory.pendingSnippets count] == 10 ||
        [[self.currentStory.storySnippets lastObject]ownerID] == self.user.userID ||
        [self.currentStory.open  isEqual: @"false"] ||
        self.user == nil) { // !self.user is not working for some reason
        
        [self.toggleButton isHidden];
    }
    self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
    
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;
    
}

- (void)followButtonHandler {
    
    if (!self.user) {
        self.followButton.enabled = NO;
    }
    
    if ([self.user.followedStories containsObject:_currentStory.storyID]) {
        self.followButton.title = @"Unfollow";
    } else {
        self.followButton.title = @"Follow";
    }
}

- (IBAction)toggleSnippetView:(id)sender {
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;
    if (self.toggleButtonBottomConstraint.constant == self.hiddenConstant) {
        self.toggleButtonBottomConstraint.constant = self.showConstant;
        [self.toggleButton setTitle:@"Return to story" forState:UIControlStateNormal];
        [self.toggleButton setBackgroundColor:[UIColor whiteColor]];
        [self.toggleButton setTitleColor:[UIColor colorWithRed:128.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
    } else if (self.toggleButtonBottomConstraint.constant == self.showConstant) {
        self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
        [self.toggleButton setTitle:@"Contribute to the story" forState:UIControlStateNormal];
        [self.toggleButton setBackgroundColor:[UIColor colorWithRed:128.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
        [self.toggleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)followButtonPressed:(id)sender {
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    tempArray = self.user.followedStories.copy;
    if ([self.user.followedStories containsObject:_currentStory.storyID]) {
        [tempArray removeObject:_currentStory.storyID];
        self.user.followedStories = tempArray.copy;
        // Send to server
    } else {
        [tempArray addObject:_currentStory.storyID];
        self.user.followedStories = tempArray.copy;
        // Send to server
    }
    
    [self followButtonHandler];
}

@end
