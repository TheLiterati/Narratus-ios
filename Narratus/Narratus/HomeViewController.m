//
//  HomeViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "HomeViewController.h"
#import "Story.h"
#import "StoryTableViewCell.h"
#import "StoryViewController.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lastUpdatedTableView;
@property (strong, nonatomic) NSArray<Story *> *allStories;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastUpdatedTableView.dataSource = self;
    self.lastUpdatedTableView.delegate = self;
    self.allStories = [[NSArray<Story *> alloc]init];
    UINib *storyNib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    [self.lastUpdatedTableView registerNib:storyNib forCellReuseIdentifier:@"StoryTableViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"StoryViewControllerFromHome"]) {
        Story *currentStory = [[Story alloc]init];
        NSInteger selectedIndex = self.lastUpdatedTableView.indexPathForSelectedRow.row;
        currentStory = self.allStories[selectedIndex];
        StoryViewController *destinationController = segue.destinationViewController;
        destinationController.currentStory = currentStory;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allStories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = @"title sample";
    cell.descriptionLabel.text = @"description sample";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"StoryViewControllerFromHome" sender:self];
}


@end
