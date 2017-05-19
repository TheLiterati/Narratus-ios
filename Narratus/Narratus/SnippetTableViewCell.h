//
//  SnippetTableViewCell.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Snippet.h"

@interface SnippetTableViewCell : UITableViewCell

@property (strong, nonatomic) Snippet *currentSnippet;
//@property (strong, nonatomic) NSString *startingSnippet;
@property (strong, nonatomic) NSString *content;

@end
