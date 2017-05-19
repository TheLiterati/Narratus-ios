//
//  OwnedStorySnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedStorySnippetViewController.h"

#import "SnippetTableViewCell.h"
#import "API.h"
#import "OwnedStoryViewController.h"

@interface OwnedStorySnippetViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property (strong, nonatomic) NSArray<Snippet *> *confirmedSnippets;
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;

@end

@implementation OwnedStorySnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.confirmedSnippets = [[NSArray<Snippet *> alloc]init];
    self.storyTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"papertexture-2061709_1920.jpg"]];
    self.storyTableView.separatorColor = [UIColor clearColor];
    self.storyTableView.dataSource = self;
    self.storyTableView.delegate = self;
    UINib *snippetNib = [UINib nibWithNibName:@"SnippetTableViewCell" bundle:nil];
    [self.storyTableView registerNib:snippetNib forCellReuseIdentifier:@"SnippetTableViewCell"];
//    self.confirmedSnippets = [API sampleSnippet];
    
    self.storyTableView.estimatedRowHeight = 50;
    self.storyTableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    
//    [self.storyTableView reloadData];
}

//-(void)viewWillAppear:(BOOL)animated {
//    OwnedStoryViewController *parent = [self parentViewController];
//    self.currentStory = parent.currentStory;
//    
//    [API fetchSnippets:^(NSArray<Snippet *> *allSnippets) {
//        self.confirmedSnippets = allSnippets;
//        [self.storyTableView reloadData];
//    } With:self.currentStory.storyID]; //self.selectedStory.storyID]
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.confirmedSnippets count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnippetTableViewCell" forIndexPath:indexPath];
        cell.content = self.currentStory.startSnippet;
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    } else {
        SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnippetTableViewCell" forIndexPath:indexPath];
        cell.content = self.confirmedSnippets[indexPath.row].content;
        
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }
}

@end
