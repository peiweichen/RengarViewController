//
//  PIEUploadViewController.m
//  TUPAI
//
//  Created by chenpeiwei on 1/27/16.
//  Copyright © 2016 Shenzhen Pires Internet Technology CO.,LTD. All rights reserved.
//

#import "RengarViewController.h"
#import "SZTextView.h"
#import "RengarPanelView.h"
#import "RengarBottomBar.h"
#import "RengarAssetCollectionViewCell.h"
#import "RengarAlbumsViewController.h"
#import "Masonry.h"
#import "UIColor+Hex.h"

@interface RengarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RengarAlbumsViewControllerDelegate>

@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) NSMutableOrderedSet *assetOrderedSet;

@property (nonatomic,strong) SZTextView *textView;
@property (nonatomic,strong) RengarPanelView *panelView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) RengarBottomBar *bottomBar;


@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) MASConstraint *collectionViewHeightConstraint;
@property (nonatomic, strong) MASConstraint *panelTopMarginConstraint;

@property (nonatomic, assign) CGFloat initialHeightOfCollectionView;
@property (nonatomic, assign) CGFloat fullExpandedHeightOfCollectionView;
@property (nonatomic, assign) CGFloat initalHeightOfCollectionViewBeforePanning;

@end



@implementation RengarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupData];
    [self setupNavBar];
    [self setupViews];
    [self setupPhotoSource];
    [self setupEvents];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_fullExpandedHeightOfCollectionView == 0) {
        _fullExpandedHeightOfCollectionView = self.textView.frame.size.height + _initialHeightOfCollectionView;
    }
    if (_initialHeightOfCollectionView == 0) {
        _initialHeightOfCollectionView = self.collectionView.frame.size.height;
    }
}
-(void)setupData {
    _assetOrderedSet = [NSMutableOrderedSet orderedSet];
    _initialHeightOfCollectionView = [UIScreen mainScreen].bounds.size.width*2.0/3.0;
}

-(void)setupEvents {

    [self.bottomBar.button addTarget:self action:@selector(tapButtonBarButton) forControlEvents:UIControlEventTouchDown];
    
    UIPanGestureRecognizer *recognizer_Panel = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnPanelView:)];
    [self.panelView addGestureRecognizer:recognizer_Panel];
    self.panelView.userInteractionEnabled = YES;
}

-(void)setupPhotoSource {
    PHFetchResult *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [assetCollections enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAssetCollection *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchOptions *options = [PHFetchOptions new];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:obj options:options];
        [fetchResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.assetOrderedSet addObject:obj];
        }];
    }];
}

- (void)updateCollectionViewWithAssetCollection:(PHAssetCollection*)assetCollection {
    _assetCollection = assetCollection;
    
    if (self.assetCollection) {
        PHFetchOptions *options = [PHFetchOptions new];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        
        [self.assetOrderedSet removeAllObjects];
        
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:options];
        [fetchResult enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.assetOrderedSet addObject:obj];
        }];
        
    } else {
        [self.assetOrderedSet removeAllObjects];
    }
    
    [self.collectionView reloadData];
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

-(void)setupNavBar {
    UILabel *titleView = [UILabel new];
    titleView.text = @"上传";
    titleView.font = [UIFont systemFontOfSize:16];
    titleView.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleView;
    [titleView sizeToFit];
    
    UIButton *barButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [barButton setTitle:@"发布" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor colorWithHex:0x000000 andAlpha:0.6] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(tapNavBarRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    barButton.titleLabel.font = [UIFont systemFontOfSize:15];

    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:barButton];

    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}


-(void)setupViews {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.panelView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomBar];
    
    [self setupViewContraints];
}


-(void)setupViewContraints {
    
//    [self.textView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self.view);
    }];
    [self.panelView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.panelTopMarginConstraint = make.top.equalTo(self.textView.mas_bottom).with.offset(2);
        make.leading.and.trailing.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.panelView.mas_bottom);
        make.leading.and.trailing.equalTo(self.view);
        self.collectionViewHeightConstraint = make.height.equalTo(@(self.initialHeightOfCollectionView)).with.priorityLow();
        make.height.greaterThanOrEqualTo(@(self.initialHeightOfCollectionView));
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.height.equalTo(@45);
        make.leading.and.trailing.and.bottom.equalTo(self.view);
    }];
    
}




-(void)albumsViewController:(RengarAlbumsViewController *)albumsViewController didDismissWithAssetCollection:(PHAssetCollection *)assetCollection {
    self.selectedIndexPath = nil;
    [self updateCollectionViewWithAssetCollection:assetCollection];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetOrderedSet.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Image
    
    RengarAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RengarAssetCollectionViewCell" forIndexPath:indexPath];
    
    PHAsset *asset = self.assetOrderedSet[indexPath.item];
    CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
    CGSize targetSize = CGSizeMake(itemSize.width*2, itemSize.height*2);
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                 targetSize:targetSize
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                      cell.imageView.image = result;
                              }];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndexPath == indexPath) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        _selectedIndexPath = nil;
        return;
    }
    _selectedIndexPath = indexPath;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self resignTextView];
    CGFloat startContentOffsetY = scrollView.contentOffset.y;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat distance = ABS(startContentOffsetY - scrollView.contentOffset.y);
        
        if (distance < 20) {
            return ;
        }
        if (startContentOffsetY > scrollView.contentOffset.y  ) {
            [self scrollViewDidScrollDown];
        }
        else if (startContentOffsetY < scrollView.contentOffset.y)
        {
            [self scrollViewDidScrollUp];
        }
        
    });
}


- (void)scrollViewDidScrollUp {
    [self resignTextView];
    [self.collectionViewHeightConstraint setOffset:_fullExpandedHeightOfCollectionView];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)scrollViewDidScrollDown {
    [self resignTextView];
    [self.collectionViewHeightConstraint setOffset:_initialHeightOfCollectionView];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

}
- (void)panOnPanelView:(id)sender {
    [self resignTextView];
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
    }

    [self.collectionViewHeightConstraint setOffset:_initalHeightOfCollectionViewBeforePanning-translatedPoint.y];

    [self.view layoutIfNeeded];

    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        _initalHeightOfCollectionViewBeforePanning = self.collectionView.frame.size.height;
    }
}


- (void)tapButtonBarButton {
    RengarAlbumsViewController *vc = [RengarAlbumsViewController new];
    vc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:NULL];
}

-(void)tapNavBarRightBarButton {
    
    if (self.textView.text.length < 3) {
        //        [Hud text:@"作业描述少于三个字符～"];
        return;
    }  else   if (self.selectedIndexPath == nil) {
        //        [Hud text:@"还没有选择图片喔～"];
        [self resignTextView];
        return;
    }
    
    [self resignTextView];
    
    if (_delegate && [_delegate respondsToSelector:@selector(rengarViewController:didFinishPickingPhotoAsset:descriptionString:)]) {
        [_delegate rengarViewController:self didFinishPickingPhotoAsset:[self.assetOrderedSet objectAtIndex:self.selectedIndexPath.row] descriptionString:self.textView.text];
    }
    
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)resignTextView {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}
-(SZTextView *)textView {
    if (_textView == nil) {
        _textView = [SZTextView new];
        _textView.placeholder = @"请输入你的作业描述";
        _textView.placeholderTextColor = [UIColor colorWithHex:0x000000 andAlpha:0.3];
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}
-(RengarPanelView *)panelView {
    if (_panelView == nil) {
        _panelView = [RengarPanelView new];
    }
    return _panelView;
}

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setMinimumInteritemSpacing:1.0f];
        [layout setMinimumLineSpacing:3.0F];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3.0 - 3, [UIScreen mainScreen].bounds.size.width/3.0 - 3);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.bounces = YES;
        _collectionView.scrollsToTop = YES;

        UINib *nib = [UINib nibWithNibName:@"RengarAssetCollectionViewCell" bundle:NULL];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"RengarAssetCollectionViewCell"];

        _collectionView.backgroundColor = [UIColor colorWithHex:0x4a4a4a andAlpha:1.0];
    }
    return _collectionView;
}

-(RengarBottomBar *)bottomBar {
    if (_bottomBar == nil) {
        _bottomBar = [RengarBottomBar new];
    }
    return _bottomBar;
}


@end
