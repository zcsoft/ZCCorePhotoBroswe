// ZCCoreImageViewController.m
//
//  Created by zconly on 11/10/15.
//

#import "ZCCoreImageViewController.h"

@interface ZCCoreImageViewController ()
<UIScrollViewDelegate>

@end

@implementation ZCCoreImageViewController

- (id)initWithImage:(UIImage *)image
{
    if(image == nil)
        return nil;
    
    if (self = [super init])
    {
        _image = image;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = self.image;
    
    //添加 UIScrollView
    //设置 UIScrollView的位置与屏幕大小相同
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    //添加图片
    self.imageView=[[UIImageView alloc]initWithImage:self.image];
    //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
    [self.scrollView addSubview:self.imageView];
    self.imageView.frame = (CGRect){(self.scrollView.frame.size.width-self.image.size.width)/2,(self.scrollView.frame.size.height-self.image.size.height)/2,self.imageView.frame.size};

    //设置UIScrollView的滚动范围和图片的真实尺寸一致
    self.scrollView.contentSize=self.image.size;
    
    //设置实现缩放
    //设置代理scrollview的代理对象
    self.scrollView.delegate=self;
    CGFloat zoomScaleW = self.scrollView.frame.size.width/self.image.size.width;
    CGFloat zoomScaleH = self.scrollView.frame.size.height/self.image.size.height;
    CGFloat zoomScale = MIN(zoomScaleW, zoomScaleH);
    //设置最大伸缩比例
    self.scrollView.maximumZoomScale = zoomScale*2;
    //设置最小伸缩比例
    self.scrollView.minimumZoomScale=zoomScale;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    //始终可以拖动
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.alwaysBounceHorizontal = YES;
    
    //手势操作
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapOne.numberOfTouchesRequired = 1;
    singleTapOne.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:singleTapOne];
    UITapGestureRecognizer *doubleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapOne.numberOfTouchesRequired = 1;
    doubleTapOne.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:doubleTapOne];
    [singleTapOne requireGestureRecognizerToFail:doubleTapOne];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc
{
    //NSLog(@"dealloc ZCCoreImageViewController");
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //始终居中
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Private methods

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate dismissCompletion:self];
        }];
    }
    else
    {
        // Zoom out
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale)
    {
        CGPoint Pointview=[tapGestureRecognizer locationInView:self.scrollView];
        CGFloat newZoomscal=2.0;
        newZoomscal=MIN(newZoomscal, self.scrollView.maximumZoomScale);
        CGSize scrollViewSize=self.scrollView.bounds.size;
        CGFloat w=scrollViewSize.width/newZoomscal;
        CGFloat h=scrollViewSize.height/newZoomscal;
        CGFloat x= Pointview.x-(w/2.0);
        CGFloat y = Pointview.y-(h/2.0);
        CGRect rectTozoom=CGRectMake(x, y, w, h);
        [self.scrollView zoomToRect:rectTozoom animated:YES];
        [self.scrollView setZoomScale:2.0 animated:YES];
    }
    else
    {
        // Zoom out
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

@end
