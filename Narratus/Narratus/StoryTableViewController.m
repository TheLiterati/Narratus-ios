//
//  StoryTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryTableViewController.h"

@interface StoryTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;
@property (strong, nonatomic) NSArray *snippets;

@end

@implementation StoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyTableView.dataSource = self;
    self.snippets = self.selectedStory.storySnippets;
    UINib *cellNib = [UINib nibWithNibName:@"snippetCell" bundle:nil];
    [self.storyTableView registerNib:cellNib forCellReuseIdentifier:@"snippetCell"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.snippets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"snippetCell" forIndexPath:indexPath];
    Snippet *snippet = [self.snippets objectAtIndex:indexPath.row];
    cell.snippetDate = snippet.acceptedDate;
    cell.snippetContent = snippet.content;
    return cell;
}


@end
