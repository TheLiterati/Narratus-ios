//
//  NewSnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewSnippetViewController.h"
#import "StoryManager.h"
#import "Snippet.h"
#import "PendingSnippetViewController.h"

@interface NewSnippetViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *snippetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;

@end

@implementation NewSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snippetTextView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger length;
    length = self.snippetTextView.text.length;
    NSInteger remaining = 250 - length;
    self.characterCounter.text = [NSString stringWithFormat:@"%li", remaining];
    
    if (remaining <= 50) {
        self.characterCounter.textColor = [UIColor redColor];
    }

}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return self.snippetTextView.text.length + (text.length - range.length) <= 250;
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    Snippet *newSnippet = [[Snippet alloc]init];
    newSnippet.pending = _snippetTextView.text;
    
    [[StoryManager.shared allSnippets] addObject:newSnippet];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pendingSnippetCreation" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
