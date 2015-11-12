//
//  ZCCorePhotoBroswe.m
//
//  Created by zconly on 11/10/15.
//

#import "ZCCorePhotoBroswe.h"
#import "ZCCoreImageViewController.h"
#import "TGRImageZoomAnimationController.h"


@interface ZCCorePhotoBroswe()
<
    UIViewControllerTransitioningDelegate,
    ZCCoreImageViewControllerDelegate
>

@property (strong, nonatomic) UIImageView *imageView;

@end


@implementation ZCCorePhotoBroswe


- (instancetype)init
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

- (void)dealloc
{
    //NSLog(@"dealloc ZCVertigo");
}

+ (BOOL)showImage:(UIImageView *)imageView
{
    if(imageView.image == nil)
        return NO;
    
    ZCCorePhotoBroswe *corePhotoBroswe = [[ZCCorePhotoBroswe alloc] init];
    corePhotoBroswe.imageView = imageView;
    corePhotoBroswe.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    ZCCoreImageViewController *viewController = [[ZCCoreImageViewController alloc] initWithImage:imageView.image];
    viewController.transitioningDelegate = corePhotoBroswe;
    
    //强引用，通过这个引用来保持封装类(ZCVertigo)不被释放
    //也可以使用static变量来保持，然后在视图隐藏后设置static为nil以便释放
    // Strong reference, through this reference to keep the wrapper classes (ZC Vertigo) is not released
    // static variables can also be used to hold, then hidden in the rear view is set to release the static to nil
    viewController.delegate = corePhotoBroswe;
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [appRootVC presentViewController:viewController animated:YES completion:nil];
    
    return YES;
}


#pragma UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:ZCCoreImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:ZCCoreImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.imageView];
    }
    return nil;
}

#pragma ZCCoreImageViewControllerDelegate

- (void)dismissCompletion:(ZCCoreImageViewController *)corePhotoBrosweVC;
{
    corePhotoBrosweVC.delegate = nil;
}

@end
