//
//  OwnedTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedTableViewController.h"
#import "OwnedStoryTableViewCell.h"
#import "User.h"
#import "Story.h"
#import "API.h"

@interface OwnedTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ownedTableView;
@property (strong, nonatomic) NSArray<Story *> *ownedStories;

@end

@implementation OwnedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ownedStories = [[NSArray<Story *> alloc]init];
    self.ownedTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName:@"OwnedStoryTableViewCell" bundle:nil];
    [self.ownedTableView registerNib:cellNib forCellReuseIdentifier:@"OwnedStoryTableViewCell"];
    self.ownedTableView.estimatedRowHeight = 50;
    self.ownedTableView.rowHeight = UITableViewAutomaticDimension;
    self.ownedStories = [API sampleStory];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOwnedStories) name:@"newStoryCreation" object:nil];
}

-(void)updateOwnedStories{
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OwnedStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnedStoryTableViewCell" forIndexPath:indexPath];
    Story *current = self.ownedStories[indexPath.row];
    
    cell.ownedStoryTitleLabel.text = current.title;
    cell.ownedStoryDescriptionLabel.text = current.description;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.ownedStories count];
}

@end
