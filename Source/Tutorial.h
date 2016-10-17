//
//  Tutorial.h
//  Branch
//
//  Created by Makenzie Schwartz on 9/2/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "CCNode.h"
#import "MainScene.h"

@interface Tutorial : CCNode

- (void)setMainScene:(MainScene *)ms;
- (void)closeTutorial;
- (void)colorize:(CCColor *)color;

@end
