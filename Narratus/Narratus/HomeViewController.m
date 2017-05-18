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
#import "API.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lastUpdatedTableView;
@property (strong, nonatomic) NSArray<Story *> *allStories;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.lastUpdatedTableView.separatorColor = [UIColor clearColor];
    self.lastUpdatedTableView.backgroundColor = [UIColor clearColor];
    self.lastUpdatedTableView.dataSource = self;
    self.lastUpdatedTableView.delegate = self;

    UINib *storyNib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    [self.lastUpdatedTableView registerNib:storyNib forCellReuseIdentifier:@"StoryTableViewCell"];

    
    self.allStories = [[NSArray<Story *> alloc]init];
//    self.allStories = [API sampleStory];

    [API fetchAllStories:^(NSArray<Story *> *allStories) {
        self.allStories = allStories;
    
    }];
    [self.lastUpdatedTableView reloadData];
    self.lastUpdatedTableView.estimatedRowHeight = 70;
    self.lastUpdatedTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allStories count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryTableViewCell" forIndexPath:indexPath];
    Story *current = self.allStories[indexPath.row];
    
    cell.titleLabel.text = current.title;
    cell.descriptionLabel.text = current.description;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryViewController *storyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    Story *selectedStory = self.allStories[indexPath.row];
    storyVC.currentStory = selectedStory;
    [self.navigationController pushViewController:storyVC animated:YES];
    
    [API postNewStoryWith:@"start snipp" with:@"yo" and:@"yee"];
    

}


@end
