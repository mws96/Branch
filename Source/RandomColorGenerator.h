//
//  RandomColorGenerator.h
//  Branch
//
//  Created by Makenzie Schwartz on 8/28/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomColorGenerator : NSObject {
    int prevColor;
    int prevPrevColor;
}

- (NSArray *)nextColor;
- (NSArray *)startColor;

@end
