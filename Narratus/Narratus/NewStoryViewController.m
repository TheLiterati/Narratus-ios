//
//  NewStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewStoryViewController.h"
#import "StoryManager.h"

@interface NewStoryViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *storyTextField;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;

@end

@implementation NewStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyTextField.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length;
    length = self.storyTextField.text.length;
    NSInteger remaining = 250 - length;
    self.characterCounter.text = [NSString stringWithFormat:@"%li", remaining];
    if (remaining <= 50) {
        self.characterCounter.text = [UIColor redColor];
    }
    if (remaining == 0) {
        self.storyTextField.enabled = NO;
    }
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    Story *newStory = [[Story alloc] init];
    newStory.title = _titleTextField.text;
    newStory.storyDescription = _descriptionTextField.text;
    newStory.storySnippets = _storyTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
    
    [[StoryManager shared].userStories addObject:newStory];
    
//    [[NSUserDefaults standardUserDefaults] setObject:newStory forKey:@"ownedStories"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newStoryCreation" object:nil];
}

@end
