//
//  StoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryViewController.h"
#import "NewSnippetViewController.h"

@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UIView *storyTableView;
@property (weak, nonatomic) IBOutlet UIView *addSnippetView;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *followButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) float hiddenConstant;
@property (nonatomic) float showConstant;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.followButton.title = @"blah";
        NSLog(@"Pending snippets: %@", self.currentStory.pendingSnippets);
    self.titleLabel.text = self.currentStory.title;

//    [self addSnippetHandler];
    [self followButtonHandler];

    
}

-(void)tokenCheckToggle {
    
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    
    if (token) {
        [self.toggleButton setHidden:NO];
    } else {
        [self.toggleButton setHidden:YES];
    }
    
}

//- (void)addSnippetHandler {
//    
//    // Gonna need to work with the story object as it's parsed from API to get this part working.
//    
////    if ([self.currentStory.pendingSnippets count] == 10 ||
////        [[self.currentStory.storySnippets lastObject]ownerID] == self.user.userID ||
////        [self.currentStory.open  isEqual: @"false"] ||
////        self.user == nil) { // !self.user is not working for some reason
////        
////        [self.toggleButton isHidden];
////    }
//}

- (void)followButtonHandler {
    
    if (!self.user) {
        self.followButton.enabled = NO;
    }
    
    if ([self.user.followedStories containsObject:_currentStory.storyID]) {
        self.followButton.title = @"Unfollow";
    } else {
        self.followButton.title = @"Follow";
    }
}

- (IBAction)toggleSnippetView:(id)sender {
    
    /*
    
    NewSnippetViewController *addSnippetView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewSnippetViewController"];
    addSnippetView.currentStory = self.currentStory;
    [self presentViewController:addSnippetView animated:YES completion:nil];
//    [self.navigationController pushViewController:addSnippetView animated:YES];
     
     */
}

/*
- (IBAction)followButtonPressed:(id)sender {
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    tempArray = self.user.followedStories.copy;
    if ([self.user.followedStories containsObject:_currentStory.storyID]) {
        [tempArray removeObject:_currentStory.storyID];
        self.user.followedStories = tempArray.copy;
        // Send to server
    } else {
        [tempArray addObject:_currentStory.storyID];
        self.user.followedStories = tempArray.copy;
        // Send to server
    }
    
    [self followButtonHandler];
}

 */


@end
