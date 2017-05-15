//
//  OwnedTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedTableViewController.h"

@interface OwnedTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ownedTableView;

@end

@implementation OwnedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ownedTableView.dataSource = self;
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
