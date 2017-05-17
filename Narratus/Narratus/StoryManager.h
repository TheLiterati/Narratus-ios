//
//  StoryManager.h
//  Narratus
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Snippet.h"

@interface StoryManager : NSObject

@property(strong, nonatomic) NSMutableArray<Story *> *userStories;
@property(strong, nonatomic) NSMutableArray<Snippet *> *allSnippets;

+(instancetype) shared;

@end
