//
//  Obstacle.m
//  Branch
//
//  Created by Makenzie Schwartz on 8/28/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle

- (void)didLoadFromCCB {
    //float delay = arc4random_uniform(4);
    //[self performSelector:@selector(beginAnimating) withObject:nil afterDelay:delay];
}

- (BOOL)isBeingUsed {
    return inUse;
}

- (void)enteringBoard {
    inUse = TRUE;
    self.visible = TRUE;
    CCAnimationManager *animationManager = self.animationManager;
    if (branchState == 1) {
        if (arc4random_uniform(100) < 50)
            [animationManager runAnimationsForSequenceNamed:@"Obstacle1_1"];
        else
            [animationManager runAnimationsForSequenceNamed:@"Obstacle2_1"];
    } else if (branchState == 3) {
        if (arc4random_uniform(100) < 50)
            [animationManager runAnimationsForSequenceNamed:@"Obstacle1_3"];
        else
            [animationManager runAnimationsForSequenceNamed:@"Obstacle2_3"];
    } else if (branchState == 7) {
        if (arc4random_uniform(100) < 50)
            [animationManager runAnimationsForSequenceNamed:@"Obstacle1_7"];
        else
            [animationManager runAnimationsForSequenceNamed:@"Obstacle2_7"];
    }
}

- (void)leavingBoard {
    inUse = FALSE;
    self.visible = FALSE;
}

- (void)setBranchState:(int)bs {
    branchState = bs;
}

- (int)getBranchState {
    return branchState;
}

- (void)beginAnimating {
    CCAnimationManager *animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"BlackAndWhite2"];
}

@end
