//
//  PendingSnippetViewController.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "PendingSnippetViewController.h"
#import "Snippet.h"
#import "PendingSnippetTableViewCell.h"
#import "API.h"

@interface PendingSnippetViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray<Snippet *> *pendingSnippets;
@property (weak, nonatomic) IBOutlet UITableView *pendingTableView;


@end

@implementation PendingSnippetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pendingSnippets = [[NSArray<Snippet *> alloc]init];
    self.pendingTableView.dataSource = self;
    self.pendingTableView.delegate = self;
    UINib *snippetNib = [UINib nibWithNibName:@"PendingSnippetTableViewCell" bundle:nil];
    [self.pendingTableView registerNib:snippetNib forCellReuseIdentifier:@"PendingSnippetTableViewCell"];
    
    // Do any additional setup after loading the view.

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pendingSnippetsUpdate) name:@"pendingSnippetSubmitted" object:nil];
}

-(void)pendingSnippetsUpdate{
    
    

    self.pendingSnippets = [API sampleSnippet];
    
    self.pendingTableView.estimatedRowHeight = 50;
    self.pendingTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pendingSnippets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PendingSnippetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingSnippetTableViewCell" forIndexPath:indexPath];
    
    cell.pendingContentLabel.text = self.pendingSnippets[indexPath.row].content;
    return cell;
}



@end
