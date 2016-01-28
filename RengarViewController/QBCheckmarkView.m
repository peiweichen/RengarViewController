//
//  QBCheckmarkView.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBCheckmarkView.h"
#import "UIColor+Hex.h"
@implementation QBCheckmarkView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self pie_commonInit];
    // Set default values
}

-(instancetype)init {
    if (self = [super init]) {
        [self pie_commonInit];
    }
    return self;
}

-(void)setSelected:(BOOL)selected {
    if (_selected == selected) {
        return;
    }
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)pie_commonInit {
    self.selected = NO;
    self.backgroundColor = [UIColor clearColor];
    self.borderWidth = 1.0;
    self.checkmarkLineWidth = 1.2;
    
    
    // Set shadow
    self.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2.0;
    
}
- (void)drawRect:(CGRect)rect
{
    if (self.selected) {
        //border
        [self.borderColorSelected setStroke];
        [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] stroke];
        
        
        // Body
        [self.bodyColorSelected setFill];
        [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] fill];
        
        // Checkmark
        UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
        checkmarkPath.lineWidth = self.checkmarkLineWidth;
        
        
        [checkmarkPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0))];
        [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0))];
        [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0))];
        
        [self.checkmarkColorSelected setStroke];
        [checkmarkPath stroke];
    } else {
        //border
        [self.borderColor setStroke];
        [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] stroke];
        
        
        // Body
        [self.bodyColor setFill];
        [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.borderWidth, self.borderWidth)] fill];
        
        // Checkmark
        UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
        checkmarkPath.lineWidth = self.checkmarkLineWidth;
        
        
        [checkmarkPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0))];
        [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0))];
        [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0))];
        
        [self.checkmarkColor setStroke];
        [checkmarkPath stroke];
    }
    
}

//
//self.borderColor = [UIColor whiteColor];
//self.bodyColor = [UIColor clearColor];
//self.checkmarkColor = [UIColor whiteColor];


-(UIColor *)bodyColor {
    if (!_bodyColor) {
        _bodyColor = [UIColor colorWithHex:0xe8e8e8 andAlpha:0.3];
    }
    return _bodyColor;
}
-(UIColor *)borderColor {
    if (!_borderColor) {
        _borderColor = [UIColor whiteColor];
    }
    return _borderColor;
}

-(UIColor *)checkmarkColor {
    if (!_checkmarkColor) {
        _checkmarkColor = [UIColor whiteColor];
    }
    return _checkmarkColor;
}

-(UIColor *)bodyColorSelected {
    if (!_bodyColorSelected) {
        _bodyColorSelected = [UIColor yellowColor];
    }
    return _bodyColorSelected;
}
-(UIColor *)borderColorSelected {
    if (!_borderColorSelected) {
        _borderColorSelected = [UIColor clearColor];
    }
    return _borderColorSelected;
}

-(UIColor *)checkmarkColorSelected {
    if (!_checkmarkColorSelected) {
        _checkmarkColorSelected = [UIColor blackColor];
    }
    return _checkmarkColorSelected;
}


@end
