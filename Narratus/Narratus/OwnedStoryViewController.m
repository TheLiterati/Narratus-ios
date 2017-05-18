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

@end

@implementation OwnedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.currentStory);
    self.titleLabel.text = self.currentStory.title;
}

- (IBAction)closedButtonPressed:(UIButton *)sender {
    
    
}


@end
