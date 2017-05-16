//
//  FollowedStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "FollowedStoryViewController.h"
#import "FollowedStoryTableViewCell.h"
#import "User.h"
#import "Story.h"
#import "API.h"

@interface FollowedStoryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *followedTableView;
@property(strong, nonatomic) NSArray<Story *> *followedStories;

@end

@implementation FollowedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.followedStories = [[NSArray<Story *> alloc]init];
    
    self.followedTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName:@"FollowedStoryTableViewCell" bundle:nil];
    [self.followedTableView registerNib:cellNib forCellReuseIdentifier:@"FollowedStoryTableViewCell"];
    
    self.followedStories = [API sampleStory];
    self.followedTableView.estimatedRowHeight = 50;
    self.followedTableView.rowHeight = UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FollowedStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowedStoryTableViewCell" forIndexPath:indexPath];
    
    Story *current = self.followedStories[indexPath.row];
    
    cell.followedStoryTitleLabel.text = current.title;
    cell.followedStoryDescriptionLabel.text = current.description;
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followedStories count];
}



@end
