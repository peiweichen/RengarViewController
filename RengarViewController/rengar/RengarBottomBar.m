//
//  RengarBottomBar.m
//  TUPAI
//
//  Created by chenpeiwei on 1/27/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import "RengarBottomBar.h"
#import "Masonry.h"
#import "UIColor+Hex.h"

@implementation RengarBottomBar

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).with.offset(15);
            make.top.and.bottom.equalTo(self);
        }];
    }
    return self;
}

-(UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"相册" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithHex:0x000000 andAlpha:0.6] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithHex:0x000000 andAlpha:0.2] forState:UIControlStateHighlighted];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _button;
}

@end
