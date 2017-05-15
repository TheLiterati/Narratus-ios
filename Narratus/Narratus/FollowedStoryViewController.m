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

@interface FollowedStoryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *followedTableView;
@property(strong, nonatomic) NSArray *followedStories;

@end

@implementation FollowedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.followedTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName:@"followedStoryCell" bundle:nil];
    [self.followedTableView registerNib:cellNib forCellReuseIdentifier:@"followedStoryCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FollowedStoryTableViewCell *cell = [_followedTableView dequeueReusableCellWithIdentifier:@"followedStoryCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell =  [tableView dequeueReusableCellWithIdentifier:@"followedStoryCell"];
    }
    
    User *user = self.followedStories;
    
    cell.followedStoryTitleLabel.text = user.followedStories;
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



@end
