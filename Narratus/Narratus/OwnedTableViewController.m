//
//  OwnedTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedTableViewController.h"
#import "OwnedStoryTableViewCell.h"

@interface OwnedTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ownedTableView;

@end

@implementation OwnedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ownedTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName:@"ownedStoryCell" bundle:nil];
    [self.ownedTableView registerNib:cellNib forCellReuseIdentifier:@"ownedStoryCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OwnedStoryTableViewCell *cell = [_ownedTableView dequeueReusableCellWithIdentifier:@"ownedStoryCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell =  [tableView dequeueReusableCellWithIdentifier:@"ownedStoryCell"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

@end
