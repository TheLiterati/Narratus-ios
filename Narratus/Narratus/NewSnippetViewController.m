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

#define  k_KEYBOARD_OFFSET 220.0

@interface NewSnippetViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *snippetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;

@end

@implementation NewSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snippetTextView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

-(void)keyboardWillAppear {
    if (self.view.frame.origin.y >= 0) {
        [self moveViewUp:YES];
    } else  if (self.view.frame.origin.y < 0) {
        [self moveViewUp:NO];
    }
}

-(void)KeyboardWillDisappear {
    if (self.view.frame.origin.y >= 0) {
        [self moveViewUp:YES];
    } else if (self.view.frame.origin.y < 0){
        [self moveViewUp:NO];
    }
}

-(void)moveViewUp:(BOOL)bMovedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    CGRect rect = self.view.frame;
    
    if (bMovedUp) {
        rect.origin.y -= k_KEYBOARD_OFFSET;
    } else {
        rect.origin.y += k_KEYBOARD_OFFSET;
        rect.size.height -= k_KEYBOARD_OFFSET;
    }
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return self.snippetTextView.text.length + (text.length - range.length) <= 250;
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    UIAlertController *contribution = [UIAlertController alertControllerWithTitle:@"Thank you for your contribution" message:@"May the story never end 📖" preferredStyle: UIAlertControllerStyleAlert];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates, Highest priority
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"📝Wanderlust more" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [self presentViewController:contribution animated:YES completion:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            [contribution addAction:action];
        });
        
        //Background Thread(global queue), medium priority aka priority_default
        Snippet *newSnippet = [[Snippet alloc]init];
        newSnippet.pending = _snippetTextView.text;
        
        [[StoryManager.shared allSnippets] addObject:newSnippet];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pendingSnippetCreation" object:nil];
        
    });
    
    
}


@end
