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
@property (nonatomic) float hiddenConstant;
@property (nonatomic) float showConstant;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenConstant = 8;
    self.showConstant = 196;
    self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;
//    if ([self.currentStory.pendingSnippets count] == 10) {
//        self.toggleButton.hidden = YES;
//    }
//    if ([self.currentStory.storySnippets lastObject]) {
//        //If user of last object is same as logged-in user
//        self.toggleButton.hidden = YES;
//    }
//     if (!logged in user) {
//    self.toggleButton.hidden = YES;

}


- (IBAction)toggleSnippetView:(id)sender {
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;
    if (self.toggleButtonBottomConstraint.constant == self.hiddenConstant) {
        self.toggleButtonBottomConstraint.constant = self.showConstant;
    } else if (self.toggleButtonBottomConstraint.constant == self.showConstant) {
        self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
    }
}


@end
