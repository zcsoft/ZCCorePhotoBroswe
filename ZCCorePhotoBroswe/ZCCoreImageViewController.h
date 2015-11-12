// ZCCoreImageViewController.h
//
//  Created by zconly on 11/10/15.
//

#import <UIKit/UIKit.h>

@class ZCCoreImageViewController;

@protocol ZCCoreImageViewControllerDelegate <NSObject>

//视图隐藏
- (void)dismissCompletion:(ZCCoreImageViewController *)tgrVc;

@end

// Simple full screen image viewer.
//
// Allows the user to view an image in full screen and double tap to zoom it.
// The view controller can be dismissed with a single tap.
@interface ZCCoreImageViewController : UIViewController

//必须是强引用，保证封装类不被释放
// Must be strong references to ensure that the package will not be released class
@property (strong, nonatomic) id<ZCCoreImageViewControllerDelegate> delegate;

// The scroll view used for zooming.
@property (strong, nonatomic) UIScrollView *scrollView;

// The image view that displays the image.
@property (strong, nonatomic) UIImageView *imageView;

// The image that will be shown.
@property (strong, nonatomic, readonly) UIImage *image;

// Initializes the receiver with the specified image.
- (id)initWithImage:(UIImage *)image;

@end
