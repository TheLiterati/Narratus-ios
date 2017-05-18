//
//  OwnedTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedTableViewController.h"
#import "StoryTableViewCell.h"
#import "User.h"
#import "Story.h"
#import "API.h"
#import "StoryManager.h"
#import "OwnedStoryViewController.h"

@interface OwnedTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownedTableView;
@property (strong, nonatomic) NSMutableArray<Story *> *ownedStories;


@end

@implementation OwnedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ownedStories = [[NSMutableArray alloc]init];
    self.ownedTableView.dataSource = self;
    self.ownedTableView.delegate = self;
    UINib *cellNib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    [self.ownedTableView registerNib:cellNib forCellReuseIdentifier:@"StoryTableViewCell"];
    self.ownedTableView.estimatedRowHeight = 50;
    self.ownedTableView.rowHeight = UITableViewAutomaticDimension;
    self.ownedStories = [API sampleStory];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOwnedStories) name:@"newStoryCreation" object:nil];
}

-(void)updateOwnedStories{
    NSLog(@"%@",[self.ownedStories lastObject]);
    
    self.ownedStories = [StoryManager shared].userStories;
    [self.ownedTableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.ownedStories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryTableViewCell" forIndexPath:indexPath];
    Story *current = self.ownedStories[indexPath.row];
    
    cell.titleLabel.text = current.title;
    cell.descriptionLabel.text = current.description;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OwnedStoryViewController *ownVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OwnedStoryViewController"];
    [self.navigationController pushViewController:ownVC animated:YES];
    
}


@end
