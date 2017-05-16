//
//  SnippetTableViewCell.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnippetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *snippetContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *snippetDateLabel;

@end
