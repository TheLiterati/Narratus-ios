//
//  NewStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "NewStoryViewController.h"
#import "StoryManager.h"
#import "API.h"

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
    [self.genrePicker selectRow:4 inComponent:0 animated:YES];
    
}


- (NSArray *)genres {
    NSArray *genres = @[@"Adventure",
                        @"Comedy",
                        @"Drama",
                        @"Fantasy",
                        @"General Fiction",
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


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.storyTextView.text = @"";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -220.0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +220.0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
//    NSInteger *row = [self.genrePicker selectedRowInComponent:0];
    
    newStory.title = _titleTextField.text;
    newStory.storyDescription = _descriptionTextField.text;
    newStory.category = [self.genres objectAtIndex:[self.genrePicker selectedRowInComponent:0]];
    NSLog(@"%@", newStory.category);
    
    newSnippet.content = _storyTextView.text; //Need to add all other snippet properties
//    [newStory.storySnippets addObject:newSnippet];
    
    NSString *title = [NSString stringWithFormat:@"%@", self.titleTextField.text];
    NSString *description = [NSString stringWithFormat:@"%@", self.descriptionTextField.text];
    NSString *startSnippet = [NSString stringWithFormat:@"%@", self.storyTextView.text];
    
    [[StoryManager shared].userStories addObject:newStory];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newStoryCreation" object:nil];
    
    [API postNewStoryWith:title with:description and:startSnippet];
    

    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Success!" message:@"Your story has been submitted!" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [success addAction:ok];
    [self presentViewController:success animated:YES completion:nil];

}

@end
