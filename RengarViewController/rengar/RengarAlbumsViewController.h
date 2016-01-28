//
//  RengarAlbumsViewController.h
//  TUPAI
//
//  Created by chenpeiwei on 1/28/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RengarAlbumsViewController;
@class PHAssetCollection;

@protocol RengarAlbumsViewControllerDelegate <NSObject>
@required
- (void)albumsViewController:(RengarAlbumsViewController *)albumsViewController didDismissWithAssetCollection:(PHAssetCollection*)assetCollection;
@end
@interface RengarAlbumsViewController : UITableViewController
@property (nonatomic, weak) id<RengarAlbumsViewControllerDelegate> delegate;

@end
