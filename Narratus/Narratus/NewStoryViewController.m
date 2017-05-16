//
//  NewStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewStoryViewController.h"
#import "StoryManager.h"

@interface NewStoryViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextView *storyTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;

@end

@implementation NewStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.storyTextView.delegate = self;

}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length;
    length = self.storyTextView.text.length;
    NSInteger remaining = 250 - length;
    self.characterCounter.text = [NSString stringWithFormat:@"%li", remaining];
    if (remaining <= 50) {
        self.characterCounter.textColor = [UIColor redColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return self.storyTextView.text.length + (text.length - range.length) <= 250;
}

- (IBAction)submitButtonPressed:(UIButton *)sender {

    
    Story *newStory = [[Story alloc] init];
    newStory.title = _titleTextField.text;
    newStory.storyDescription = _descriptionTextField.text;
    newStory.storySnippets = _storyTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
    
    [[StoryManager shared].userStories addObject:newStory];
   
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newStoryCreation" object:nil];

    //self.titleTextField.text = title
    //self.descriptionTextField.text = description
    //self.storyTextView.text = content
    UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your story has been submitted!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [success show];
    [self.navigationController popViewControllerAnimated:YES];

}

@end
