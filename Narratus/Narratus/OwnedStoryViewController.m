//
//  OwnedStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedStoryViewController.h"

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


- (void) buttonHandler {
    if (_currentStory.open == [NSString stringWithFormat:@"true"]) {
        self.openCloseButton.titleLabel.text = @"Close story";
    } else {
        self.openCloseButton.titleLabel.text = @"Open story";
    }
}

- (IBAction)closedButtonPressed:(UIButton *)sender {
    if (_currentStory.open == @"true") {
        _currentStory.open = @"false";
    } else if (_currentStory.open == @"false") {
        _currentStory.open = @"true";
    }
    // Send to server
    [self buttonHandler];
}


@end
