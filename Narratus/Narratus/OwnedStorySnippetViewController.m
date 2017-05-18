//
//  OwnedStorySnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedStorySnippetViewController.h"
#import "Snippet.h"
#import "SnippetTableViewCell.h"
#import "API.h"

@interface OwnedStorySnippetViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<Snippet *> *confirmedSnippets;
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;

@end

@implementation OwnedStorySnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmedSnippets = [[NSArray<Snippet *> alloc]init];
    self.storyTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"papertexture-2061709_1920.jpg"]];
    self.storyTableView.separatorColor = [UIColor clearColor];
    self.storyTableView.dataSource = self;
    self.storyTableView.delegate = self;
    UINib *snippetNib = [UINib nibWithNibName:@"SnippetTableViewCell" bundle:nil];
    [self.storyTableView registerNib:snippetNib forCellReuseIdentifier:@"SnippetTableViewCell"];
    self.confirmedSnippets = [API sampleSnippet];
    
    self.storyTableView.estimatedRowHeight = 50;
    self.storyTableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.confirmedSnippets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnippetTableViewCell" forIndexPath:indexPath];
    
    cell.snippetContentLabel.text = [NSString stringWithFormat:@"     %@", self.confirmedSnippets[indexPath.row].content];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}

@end
