//
//  StoryTableViewCell.h
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface StoryTableViewCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property(strong, nonatomic) Story *currentStory;
@end
