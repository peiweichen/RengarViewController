//
//  RengarPanelView.m
//  TUPAI
//
//  Created by chenpeiwei on 1/27/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import "RengarPanelView.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
@implementation RengarPanelView

-(instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        
        UIView *stick = [UIView new];
        stick.backgroundColor = [UIColor colorWithHex:0xffffff andAlpha:0.6];
        stick.layer.cornerRadius = 3;
        stick.clipsToBounds = YES;
        
        [self addSubview:stick];

        [stick mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 4));
            make.center.equalTo(self);
        }];
        
    }
    return self;
}


@end
