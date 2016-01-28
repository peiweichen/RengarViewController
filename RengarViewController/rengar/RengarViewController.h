//
//  PIEUploadViewController.h
//  TUPAI
//
//  Created by chenpeiwei on 1/27/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class RengarViewController;

@protocol RengarViewControllerDelegate <NSObject>
@required
- (void)rengarViewController:(RengarViewController *)rengarViewController didFinishPickingPhotoAsset:(PHAsset*)asset descriptionString:(NSString*)descriptionString;
@end


@interface RengarViewController : UIViewController

@property (nonatomic, weak) id<RengarViewControllerDelegate> delegate;


@end
