//
//  FollowedStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "FollowedStoryViewController.h"
#import "StoryTableViewCell.h"
#import "User.h"
#import "Story.h"
#import "API.h"
#import "StoryViewController.h"
#import "StoryManager.h"

@interface FollowedStoryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *followedTableView;
@property(strong, nonatomic) NSArray<Story *> *followedStories;

@end

@implementation FollowedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.followedStories = [[NSArray<Story *> alloc]init];
    
    self.followedTableView.dataSource = self;
    self.followedTableView.delegate = self;
    UINib *cellNib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    [self.followedTableView registerNib:cellNib forCellReuseIdentifier:@"StoryTableViewCell"];
    
    self.followedStories = [API sampleStory];
    self.followedTableView.estimatedRowHeight = 50;
    self.followedTableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followedStories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryTableViewCell" forIndexPath:indexPath];
    
    cell.currentStory = self.followedStories[indexPath.row];
    
//    cell.titleLabel.text = current.title;
//    cell.descriptionLabel.text = current.storyDescription;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoryViewController *storyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    Story *selectedStory = self.followedStories[indexPath.row];
    
    storyVC.currentStory = selectedStory;
    [self.navigationController pushViewController:storyVC animated:YES];
}



@end
