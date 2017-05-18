//
//  StoryTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryTableViewController.h"
#import "SnippetTableViewCell.h"
#import "Snippet.h"
#import "API.h"

@interface StoryTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;
@property (strong, nonatomic) NSArray<Snippet *> *allSnippets;

@end

@implementation StoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"papertexture-2061709_1920.jpg"]];
    self.storyTableView.separatorColor = [UIColor clearColor];
    self.storyTableView.dataSource = self;
    self.allSnippets = [[NSArray<Snippet *> alloc]init];
    UINib *cellNib = [UINib nibWithNibName:@"SnippetTableViewCell" bundle:nil];
    [self.storyTableView registerNib:cellNib forCellReuseIdentifier:@"SnippetTableViewCell"];
    self.storyTableView.estimatedRowHeight = 50;
    self.storyTableView.rowHeight = UITableViewAutomaticDimension;

    self.allSnippets = [API sampleSnippet];
    [self.storyTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allSnippets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnippetTableViewCell" forIndexPath:indexPath];
    Snippet *current = self.allSnippets[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSString *dateString = [dateFormatter stringFromDate:current.createdDate];
//    NSLog(@"%@", dateString);
    cell.snippetContentLabel.text = [NSString stringWithFormat:@"     %@", [current content]];
    cell.snippetDateLabel.text = @"date goes here";
    cell.backgroundColor=[UIColor clearColor];

    return cell;
}


@end
