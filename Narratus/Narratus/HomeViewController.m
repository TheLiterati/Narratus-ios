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

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lastUpdatedTableView;
@property (strong, nonatomic) NSArray<Story *> *allStories;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allStories = [[NSArray<Story *> alloc]init];
    UINib *storyNib = [UINib nibWithNibName:@"StoryTableViewCell" bundle:nil];
    [self.lastUpdatedTableView registerNib:storyNib forCellReuseIdentifier:@"StoryTableViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
}


@end
