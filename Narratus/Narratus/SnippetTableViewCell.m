//
//  SnippetTableViewCell.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "SnippetTableViewCell.h"

@interface SnippetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *snippetContentLabel;

@end

@implementation SnippetTableViewCell

-(void)setCurrentSnippet:(Snippet *)currentSnippet {
    _currentSnippet = currentSnippet;
//    self.pendingContentLabel.text = currentSnippet.content;
    
    self.snippetContentLabel.text = currentSnippet.content;
//    self.snippetDateLabel.text = [currentSnippet 
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
