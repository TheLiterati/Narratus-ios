//
//  SnippetTableViewCell.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "SnippetTableViewCell.h"

@interface SnippetTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *snippetDate;
@property (weak, nonatomic) IBOutlet UILabel *snippetContext;


@end

@implementation SnippetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.snippetDate.transform = CGAffineTransformMakeRotation (3.14/2);
    self.snippetDate.text = self.cellSnippet.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
