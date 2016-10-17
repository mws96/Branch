//
//  StartBackground.h
//  Branch
//
//  Created by Makenzie Schwartz on 9/1/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "CCNode.h"

@interface StartBackground : CCNode

- (void)fadeOut;
- (void)fadeIn;
- (void)stopAllObstacleActions;
- (void)colorize:(CCColor *)color;
- (void)replayScreen;
- (void)menuScreen;

@end
