//
//  CCNodeGradient+colorbreakdown.m
//  Branch
//
//  Created by Makenzie Schwartz on 8/28/15.
//  Copyright (c) 2015 Makenzie Schwartz. All rights reserved.
//

#import "CCNodeGradient+colorbreakdown.h"

@implementation CCNodeGradient (colorbreakdown)
-(float)startcolorR {
    return self.startColor.red;
}
-(void)setStartcolorR:(float)startcolorR {
    self.startColor = [CCColor colorWithRed:startcolorR green:self.startColor.green blue:self.startColor.blue alpha:self.startColor.alpha];
}
-(float)startcolorG {
    return self.startColor.green;
}
-(void)setStartcolorG:(float)startcolorG {
    self.startColor = [CCColor colorWithRed:self.startColor.red green:startcolorG blue:self.startColor.blue alpha:self.startColor.alpha];
}
-(float)startcolorB {
    return self.startColor.blue;
}
-(void)setStartcolorB:(float)startcolorB {
    self.startColor = [CCColor colorWithRed:self.startColor.red green:self.startColor.green blue:startcolorB alpha:self.startColor.alpha];
}
-(float)endcolorR {
    return self.endColor.red;
}
-(void)setEndcolorR:(float)endcolorR {
    self.endColor = [CCColor colorWithRed:endcolorR green:self.endColor.green blue:self.endColor.blue alpha:self.endColor.alpha];
}
-(float)endcolorG {
    return self.endColor.green;
}
-(void)setEndcolorG:(float)endcolorG {
    self.endColor = [CCColor colorWithRed:self.endColor.red green:endcolorG blue:self.endColor.blue alpha:self.endColor.alpha];
}
-(float)endcolorB {
    return self.endColor.blue;
}
-(void)setEndcolorB:(float)endcolorB {
    self.endColor = [CCColor colorWithRed:self.endColor.red green:self.endColor.green blue:endcolorB alpha:self.endColor.alpha];
}
-(float)startcolorHue {
    CGFloat oldhue, saturation, brightness, alpha;
    [self.startColor.UIColor getHue:&oldhue saturation:&saturation brightness:&brightness alpha:&alpha];
    return oldhue;
}
-(void)setStartcolorHue:(float)startcolorHue {
    CGFloat oldhue, saturation, brightness, alpha;
    [self.startColor.UIColor getHue:&oldhue saturation:&saturation brightness:&brightness alpha:&alpha];
    self.startColor = [CCColor colorWithUIColor:[UIColor colorWithHue:startcolorHue saturation:saturation brightness:brightness alpha:alpha]];
}
-(float)endcolorHue {
    CGFloat oldhue, saturation, brightness, alpha;
    [self.endColor.UIColor getHue:&oldhue saturation:&saturation brightness:&brightness alpha:&alpha];
    return oldhue;
}
-(void)setEndcolorHue:(float)endcolorHue {
    CGFloat oldhue, saturation, brightness, alpha;
    [self.endColor.UIColor getHue:&oldhue saturation:&saturation brightness:&brightness alpha:&alpha];
    self.endColor = [CCColor colorWithUIColor:[UIColor colorWithHue:endcolorHue saturation:saturation brightness:brightness alpha:alpha]];
}
-(CGFloat)vectorX {
    return self.vector.x;
}
-(void)setVectorX:(CGFloat)vectorX {
    self.vector = ccp(vectorX, self.vector.y);
}
-(CGFloat)vectorY {
    return self.vector.y;
}
-(void)setVectorY:(CGFloat)vectorY {
    self.vector = ccp(self.vector.x, vectorY);
}
@end
