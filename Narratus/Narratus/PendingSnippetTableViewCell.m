//
//  PendingSnippetTableViewCell.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "PendingSnippetTableViewCell.h"

@interface PendingSnippetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *pendingContentLabel;

@end

@implementation PendingSnippetTableViewCell

-(void)setCurrentSnippet:(Snippet *)currentSnippet {
    _currentSnippet = currentSnippet;
    self.pendingContentLabel.text = currentSnippet.content;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectButtonPressed:(UIButton *)sender {
    self.currentSnippet.accepted = @"True";
    NSLog(@"accepted: %@", self.currentSnippet.accepted);
}

@end
