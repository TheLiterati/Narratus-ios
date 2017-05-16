//
//  NewStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewStoryViewController.h"

@interface NewStoryViewController () <UITextViewDelegate>
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
    //self.titleTextField.text = title
    //self.descriptionTextField.text = description
    //self.storyTextView.text = content
}

@end
