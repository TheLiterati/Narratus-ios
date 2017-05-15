//
//  FollowedStoryViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "FollowedStoryViewController.h"

@interface FollowedStoryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *followedTableView;

@end

@implementation FollowedStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.followedTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName:@"followedStoryCell" bundle:nil];
    [self.followedTableView registerNib:cellNib forCellReuseIdentifier:@"followedStoryCell"];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



@end
