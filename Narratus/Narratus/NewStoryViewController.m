//
//  NewStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewStoryViewController.h"
#import "StoryManager.h"

@interface NewStoryViewController () <UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextView *storyTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounter;
@property (strong, nonatomic) NSArray *genres;
@property (weak, nonatomic) IBOutlet UIPickerView *genrePicker;

@end

@implementation NewStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genres = [self genres];
    self.storyTextView.delegate = self;
    self.genrePicker.dataSource = self;
    self.genrePicker.delegate = self;
}


- (NSArray *)genres {
    NSArray *genres = @[@"General Fiction",
                        @"Adventure",
                        @"Comedy",
                        @"Drama",
                        @"Erotica",
                        @"Fantasy",
                        @"Horror",
                        @"Literary Fiction",
                        @"Mystery",
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.genres count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.genres[row];
}


- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    Story *newStory = [[Story alloc] init];
    Snippet *newSnippet = [[Snippet alloc]init];
    NSInteger *row = [self.genrePicker selectedRowInComponent:0];
    
    newStory.title = _titleTextField.text;
    newStory.storyDescription = _descriptionTextField.text;
    newStory.category = [self.genres objectAtIndex:row];
    NSLog(@"%@", newStory.category);
    
    newSnippet.content = _storyTextView.text; //Need to add all other snippet properties
//    [newStory.storySnippets addObject:newSnippet];
    
    [[StoryManager shared].userStories addObject:newStory];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newStoryCreation" object:nil];

    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your story has been submitted!" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [success addAction:ok];
    [self presentViewController:success animated:YES completion:nil];

}

@end
