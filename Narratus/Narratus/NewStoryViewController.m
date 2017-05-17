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
@property (weak, nonatomic) IBOutlet UITextView *storyTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;
@property (strong, nonatomic) NSArray *genres;

@end

@implementation NewStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genres = [self genres];
    self.storyTextView.delegate = self;
}


- (NSArray *)genres {
    NSArray *genres = @[@"Adventure",
                        @"Comedy",
                        @"Drama",
                        @"Erotica",
                        @"Fantasy",
                        @"Literary",
                        @"Mysteries",
                        @"Nonfiction",
                        @"Poetry",
                        @"Romance",
                        @"Science Fiction",
                        @"Thriller"];
    return genres;
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
    newStory.storySnippets = _storyTextView.text;
    
    [[StoryManager shared].userStories addObject:newStory];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newStoryCreation" object:nil];

    //self.titleTextField.text = title
    //self.descriptionTextField.text = description
    //self.storyTextView.text = content
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your story has been submitted!" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [success addAction:ok];
    [self presentViewController:success animated:YES completion:nil];

}

@end
