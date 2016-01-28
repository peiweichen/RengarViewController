//
//  RengarAlbumTableViewCell.m
//  TUPAI
//
//  Created by chenpeiwei on 1/28/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import "RengarAlbumTableViewCell.h"

@implementation RengarAlbumTableViewCell

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    
    self.imageView1.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView1.layer.borderWidth = borderWidth;
    self.imageView1.layer.cornerRadius = 5.0;

}


@end
