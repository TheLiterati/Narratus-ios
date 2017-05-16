//
//  StoryTableViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryTableViewController.h"
#import "API.h"
#import "Snippet.h"

@interface StoryTableViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;
//@property (strong, nonatomic) NSArray *snippets;
@property (strong, nonatomic) NSArray<Snippet *> *allSnippets;

@end

@implementation StoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyTableView.dataSource = self;
//    self.snippets = self.selectedStory.storySnippets;
    self.allSnippets = [[NSArray<Snippet *> alloc]init];
    UINib *cellNib = [UINib nibWithNibName:@"SnippetTableViewCell" bundle:nil];
    [self.storyTableView registerNib:cellNib forCellReuseIdentifier:@"SnippetTableViewCell"];
    
    self.allSnippets = [API sampleSnippet];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allSnippets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnippetTableViewCell" forIndexPath:indexPath];
    Snippet *snippet = self.allSnippets[indexPath.row];
//    cell.snippetDate = snippet.acceptedDate;
//    cell.snippetContent = snippet.content;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = [dateFormatter stringFromDate:snippet.createdDate];
    cell.snippetContent.text = snippet.content;
    cell.snippetDate.text = dateString;
    return cell;
}


@end
