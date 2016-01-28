//
//  RengarAssetCellCollectionViewCell.m
//  TUPAI
//
//  Created by chenpeiwei on 1/27/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import "RengarAssetCollectionViewCell.h"
#import "QBCheckmarkView.h"

@interface RengarAssetCollectionViewCell()
@property (weak, nonatomic) IBOutlet QBCheckmarkView *checkmarkView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@end
@implementation RengarAssetCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3.0;
    _overlayView.layer.borderColor = [UIColor yellowColor].CGColor;
    _overlayView.layer.borderWidth = 1.0;
    _overlayView.layer.cornerRadius = 3.0;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    self.overlayView.hidden = selected ? NO:YES;
    self.checkmarkView.selected = selected;
}
@end
