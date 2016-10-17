//
//  StartBackground.m
//  Branch
//
//  Created by Makenzie Schwartz on 9/1/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "StartBackground.h"
#import "Obstacle.h"
#import "RandomColorGenerator.h"

@implementation StartBackground {
    Obstacle *_bgOb1;
    Obstacle *_bgOb2;
    Obstacle *_bgOb3;
    Obstacle *_bgOb4;
    CCSprite *_bgBoard;
}

- (void)didLoadFromCCB {
    RandomColorGenerator *colorGen = [[RandomColorGenerator alloc] init];
    [self colorize:[[colorGen startColor] objectAtIndex:2]];
    CCAnimationManager *animationManager = _bgOb1.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_3"];
    animationManager = _bgOb2.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_3"];
    animationManager = _bgOb3.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_3"];
    animationManager = _bgOb4.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_3"];
}

- (void)fadeOut {
    [_bgOb1 runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_bgOb2 runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_bgOb3 runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_bgOb4 runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_bgBoard runAction:[CCActionFadeOut actionWithDuration:0.3]];
}

- (void)fadeIn {
    [_bgOb1 runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_bgOb2 runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_bgOb3 runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_bgOb4 runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_bgBoard runAction:[CCActionFadeIn actionWithDuration:1.0]];
}

- (void)stopAllObstacleActions {
    [_bgOb1 stopAllActions];
    [_bgOb2 stopAllActions];
    [_bgOb3 stopAllActions];
    [_bgOb4 stopAllActions];
    [_bgBoard stopAllActions];
}

- (void)colorize:(CCColor *)color {
    [_bgOb1 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
    [_bgOb2 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
    [_bgOb3 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
    [_bgOb4 runAction:[CCActionTintTo actionWithDuration:0.1 color:color]];
}

- (void)replayScreen {
    [_bgBoard setTexture:[CCTexture textureWithFile:@"Boards/board_d3_bg2.png"]];
}

- (void)menuScreen {
    [_bgBoard runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.2], [CCActionSpriteFrame actionWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Boards/board_d3_bg.png"]], [CCActionFadeIn actionWithDuration:0.2], nil]];
    //[_bgBoard setTexture:[CCTexture textureWithFile:@"Boards/board_d3_bg.png"]];
}

@end
