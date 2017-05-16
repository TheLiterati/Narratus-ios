//
//  StoryManager.m
//  Narratus
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import "StoryManager.h"

@implementation StoryManager

+(instancetype) shared {
    
    static StoryManager *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        shared = [[self alloc]init];
        
    });
    return shared;
    
}

-(instancetype)init {
    self= [super init];
    
    if (self) {
        self.userStories = [[NSMutableArray alloc]init];
        
    }
    return self;
}

@end
