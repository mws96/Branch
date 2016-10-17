//
//  Obstacle.h
//  Branch
//
//  Created by Makenzie Schwartz on 8/28/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "CCSprite.h"

@interface Obstacle : CCSprite {
    BOOL inUse;
    int branchState;
}

- (BOOL)isBeingUsed;
- (void)enteringBoard;
- (void)leavingBoard;
- (void)setBranchState:(int)bs;
- (int)getBranchState;
- (void)beginAnimating;

@end
