//
//  Tutorial.m
//  Branch
//
//  Created by Makenzie Schwartz on 9/2/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "Tutorial.h"
#import "Obstacle.h"
#import "MainScene.h"

@implementation Tutorial {
    Obstacle *_tutOb1;
    Obstacle *_tutOb2;
    MainScene *_mainScene;
}

- (void)didLoadFromCCB {
    [self colorize:[CCColor colorWithRed:0.52 green:0.77 blue:0.82]];
    CCAnimationManager *animationManager = _tutOb1.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_1"];
    animationManager = _tutOb2.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_1"];
}

- (void)setMainScene:(MainScene *)ms {
    _mainScene = ms;
}

- (void)colorize:(CCColor *)color {
    [_tutOb1 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
    [_tutOb2 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
}

- (void)closeTutorial {
    [_mainScene tutorialClosed];
    [self removeFromParent];
}

@end
