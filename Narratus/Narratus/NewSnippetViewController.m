//
//  NewSnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewSnippetViewController.h"

@interface NewSnippetViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *snippetTextField;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;


@end

@implementation NewSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snippetTextField.delegate = self;
}


- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length;
    length = self.snippetTextField.text.length;
    NSInteger remaining = 250 - length;
    self.characterCounter.text = [NSString stringWithFormat:@"%li", remaining];
    if (remaining <= 50) {
        self.characterCounter.text = [UIColor redColor];
    }
    if (remaining == 0) {
        self.snippetTextField.enabled = NO;
    }
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pendingSnippetSubmitted" object:nil];
}


@end
