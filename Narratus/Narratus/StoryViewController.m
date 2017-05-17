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
    self.hiddenConstant = 0.f;
    self.showConstant = 196;
    
    if ([self.currentStory.pendingSnippets count] == 10) {         // or if user is last contributer or user is not logged in
        [self.toggleButton isHidden];
    } else {
        self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
    }
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;

}

- (IBAction)toggleSnippetView:(id)sender {
    [self.childViewControllers[1] view].hidden = ![self.childViewControllers[1] view].hidden;
    if (self.toggleButtonBottomConstraint.constant == self.hiddenConstant) {
        self.toggleButtonBottomConstraint.constant = self.showConstant;
        [self.toggleButton setTitle:@"Cancel contribution" forState:UIControlStateNormal];
    } else if (self.toggleButtonBottomConstraint.constant == self.showConstant) {
        self.toggleButtonBottomConstraint.constant = self.hiddenConstant;
        [self.toggleButton setTitle:@"Contribute to the story" forState:UIControlStateNormal];
    }
}


@end
