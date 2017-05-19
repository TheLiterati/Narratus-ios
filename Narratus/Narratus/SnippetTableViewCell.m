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

//-(void)setCurrentSnippet:(Snippet *)currentSnippet {
//    
////    if (!self.startingSnippet) {
////        <#statements#>
////    } else {
////        <#statements#>
////    }
////    
////    _currentSnippet = currentSnippet;
//    self.snippetContentLabel.text = self.content;
//}

-(void)setContent:(NSString *)content {
    _content = content;
    self.snippetContentLabel.text = _content;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
