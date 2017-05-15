//
//  OwnedStorySnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "OwnedStorySnippetViewController.h"
#import "Snippet.h"
#import "OwnedSnippetTableViewCell.h"

@interface OwnedStorySnippetViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray<Snippet *> *confirmedSnippets;
@property (weak, nonatomic) IBOutlet UITableView *storyTableView;

@end

@implementation OwnedStorySnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmedSnippets = [[NSArray<Snippet *> alloc]init];
    self.storyTableView.dataSource = self;
    self.storyTableView.delegate = self;
    UINib *snippetNib = [UINib nibWithNibName:@"OwnedSnippetTableViewCell" bundle:nil];
    [self.storyTableView registerNib:snippetNib forCellReuseIdentifier:@"OwnedSnippetTableViewCell"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.confirmedSnippets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OwnedSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnedSnippetTableViewCell" forIndexPath:indexPath];
    
    cell.contentLabel.text = self.confirmedSnippets[indexPath.row].content;
    
    return cell;
    
}

@end
