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
#import "OwnedStoryViewController.h"

@interface OwnedTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownedTableView;
@property (strong, nonatomic) NSArray<Story *> *ownedStories;

@end

@implementation OwnedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ownedStories = [[NSArray<Story *> alloc]init];
    self.ownedTableView.dataSource = self;
    self.ownedTableView.delegate = self;
    UINib *cellNib = [UINib nibWithNibName:@"OwnedStoryTableViewCell" bundle:nil];
    [self.ownedTableView registerNib:cellNib forCellReuseIdentifier:@"OwnedStoryTableViewCell"];
    self.ownedTableView.estimatedRowHeight = 50;
    self.ownedTableView.rowHeight = UITableViewAutomaticDimension;
    self.ownedStories = [API sampleStory];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"OwnedStoryViewController"]) {
        //        Story *currentStory = [[Story alloc]init];
        //        NSInteger selectedIndex = self.lastUpdatedTableView.indexPathForSelectedRow.row;
        //        currentStory = self.allStories[selectedIndex];
//        StoryViewController *destinationController = segue.destinationViewController;
        OwnedStoryViewController *destinationController = segue.destinationViewController;
        //        destinationController.currentStory = currentStory;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.ownedStories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OwnedStoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnedStoryTableViewCell" forIndexPath:indexPath];
    Story *current = self.ownedStories[indexPath.row];
    
    cell.ownedStoryTitleLabel.text = current.title;
    cell.ownedStoryDescriptionLabel.text = current.description;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    OwnedStoryViewController
    [self performSegueWithIdentifier:@"OwnedStoryViewController" sender:self];
}


@end
