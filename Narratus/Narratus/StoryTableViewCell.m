//
//  StoryTableViewCell.m
//  Narratus
//
//  Created by Christina Lee on 5/15/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryTableViewCell.h"

@interface StoryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation StoryTableViewCell

-(void)setCurrentStory:(Story *)currentStory {
    _currentStory = currentStory;
    self.titleLabel.text = currentStory.title;
    self.descriptionLabel.text = currentStory.storyDescription;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
