//
//  OwnedStorySnippetViewControllerTest.m
//  Narratus
//
//  Created by Mike Miksch on 5/16/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OwnedStorySnippetViewController.h"

@interface OwnedStorySnippetViewControllerTest : XCTestCase

@property (strong, nonatomic) UIStoryboard *testStoryboard;
@property (strong, nonatomic) OwnedStorySnippetViewController *testController;

@end

@implementation OwnedStorySnippetViewControllerTest

- (void)setUp {
    [super setUp];
    self.testStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self.testController = [self.testStoryboard instantiateViewControllerWithIdentifier:@"OwnedStorySnippetViewController"];

}

- (void)tearDown {
    self.testController = nil;
    self.testStoryboard = nil;
    [super tearDown];
}



@end
