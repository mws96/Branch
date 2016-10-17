//
//  RandomColorGenerator.m
//  Branch
//
//  Created by Makenzie Schwartz on 8/28/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "RandomColorGenerator.h"

@implementation RandomColorGenerator

- (RandomColorGenerator *)init {
    if (self == [super init]) {
        prevColor = 0;
        prevPrevColor = -1;
        return self;
    }
    return nil;
}

- (NSArray *)nextColor {
    int rand = arc4random_uniform(100);
    if (rand >= 0 && rand <= 9) {
        if (prevColor == 0 || prevPrevColor == 0) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 0;
        return [self blueBrightColor];
    } else if (rand >= 10 && rand <= 19) {
        if (prevColor == 1 || prevPrevColor == 1) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 1;
        return [self blueColor];
    } else if (rand >= 20 && rand <= 29) {
        if (prevColor == 2 || prevPrevColor == 2) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 2;
        return [self blueGreenColor];
    } else if (rand >= 30 && rand <= 39) {
        if (prevColor == 3 || prevPrevColor == 3) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 3;
        return [self bluePurpleColor];
    } else if (rand >= 40 && rand <= 49) {
        if (prevColor == 4 || prevPrevColor == 4) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 4;
        return [self purpleColor];
    } else if (rand >= 50 && rand <= 59) {
        if (prevColor == 5 || prevPrevColor == 5) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 5;
        return [self purpleRedColor];
    } else if (rand >= 60 && rand <= 69) {
        if (prevColor == 6 || prevPrevColor == 6) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 6;
        return [self redColor];
    } else if (rand >= 70 && rand <= 79) {
        if (prevColor == 7 || prevPrevColor == 7) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 7;
        return [self orangeColor];
    } else if (rand >= 80 && rand <= 89) {
        if (prevColor == 8 || prevPrevColor == 8) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 8;
        return [self greenColor];
    } else if (rand >= 90 && rand <= 100) {
        if (prevColor == 9 || prevPrevColor == 9) {
            return [self nextColor];
        }
        prevPrevColor = prevColor;
        prevColor = 9;
        return [self goldColor];
    } else
        return nil;
}

- (NSArray *)startColor {
    return [self blueBrightColor];
}

// Dark, light, obstacle
- (NSArray *)blueBrightColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#006288"],
            [self colorWithHexString:@"#0ABBFF"],
            [self colorWithHexString:@"#76D9FF"], nil];
}

// Dark, light, obstacle
- (NSArray *)blueColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#002093"],
            [self colorWithHexString:@"#1E4EFF"],
            [self colorWithHexString:@"#819CFF"], nil];
}

// Dark, light, obstacle
- (NSArray *)blueGreenColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#009354"],
            [self colorWithHexString:@"#0BBD71"],
            [self colorWithHexString:@"#61FFBB"], nil];
}

// Dark, light, obstacle
- (NSArray *)bluePurpleColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#2D0094"],
            [self colorWithHexString:@"#5F1AFF"],
            [self colorWithHexString:@"#A67FFF"], nil];
}

// Dark, light, obstacle
- (NSArray *)purpleColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#4C0092"],
            [self colorWithHexString:@"#8E12FF"],
            [self colorWithHexString:@"#BF7AFF"], nil];
}

// Dark, light, obstacle
- (NSArray *)purpleRedColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#9C007A"],
            [self colorWithHexString:@"#C60B9D"],
            [self colorWithHexString:@"#FF61DC"], nil];
}

// Dark, light, obstacle
- (NSArray *)redColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#7D151A"],
            [self colorWithHexString:@"#BB272E"],
            [self colorWithHexString:@"#F05B62"], nil];
}

// Dark, light, obstacle
- (NSArray *)orangeColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#C86500"],
            [self colorWithHexString:@"#FF8407"],
            [self colorWithHexString:@"#FFA447"], nil];
}

// Dark, light, obstacle
- (NSArray *)greenColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#007219"],
            [self colorWithHexString:@"#0A8C27"],
            [self colorWithHexString:@"#15BB3A"], nil];
}

// Dark, light, obstacle
- (NSArray *)goldColor {
    return [NSArray arrayWithObjects:
            [self colorWithHexString:@"#D6AF00"],
            [self colorWithHexString:@"#FFD100"],
            [self colorWithHexString:@"#FFE675"], nil];
}

// takes @"#123456"
- (CCColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}

// takes 0x123456
- (CCColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [CCColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}


@end
