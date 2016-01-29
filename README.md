# RengarViewController
An animated imagePicker Controller moved by panning and scroll

 1.Simply push instance of RengarViewController

 2.Implement the delegate which has method that return the picked PHAsset and textView's text that you input.
	
	
	RengarViewController *vc = [RengarViewController new];
	vc.delegate = self;
		
	[self.navigationController pushViewController:vc animated:YES];
		
		
		
		
	@protocol RengarViewControllerDelegate <NSObject>
		
	@required
		
	- (void)rengarViewController:(RengarViewController *)rengarViewController didFinishPickingPhotoAsset:(PHAsset*)asset descriptionString:(NSString*)descriptionString;
	
	@end

![alt tag](https://github.com/peiweichen/RengarViewController/blob/master/RengarViewController/2.pic.jpg)
![alt tag](https://github.com/peiweichen/RengarViewController/blob/master/RengarViewController/3.pic.jpg)
![alt tag](https://github.com/peiweichen/RengarViewController/blob/master/RengarViewController/1.pic.jpg)
![alt tag](https://github.com/peiweichen/RengarViewController/blob/master/RengarViewController/4.pic.jpg)
