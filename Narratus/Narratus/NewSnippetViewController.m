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
#import "API.h"


@interface NewSnippetViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *snippetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;

@end

@implementation NewSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snippetTextView.delegate = self;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.snippetTextView.text = @"";
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return self.snippetTextView.text.length + (text.length - range.length) <= 250;
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    /* //Background Thread(global queue), medium priority aka priority_default
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    });
     */
    
    Snippet *newSnippet = [[Snippet alloc]init];
    newSnippet.pending = self.snippetTextView.text;
    newSnippet.content = self.snippetTextView.text;
    
    [[StoryManager.shared allSnippets] addObject:newSnippet];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pendingSnippetCreation" object:nil];
    
    UIAlertController *contribution = [UIAlertController alertControllerWithTitle:@"Thank you for your contribution" message:@"May the story never end 📖" preferredStyle: UIAlertControllerStyleAlert];
    
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates, Highest priority
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"📝Wanderlust more" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [contribution addAction:action];
            [self presentViewController:contribution animated:YES completion:nil];
            
        });
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
