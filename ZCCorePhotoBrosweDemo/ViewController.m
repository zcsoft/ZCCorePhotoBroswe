//
//  ViewController.m
//  ZCCorePhotoBrosweDemo
//
//  Created by cuibo on 11/11/15.
//  Copyright © 2015 cuibo. All rights reserved.
//

#import "ViewController.h"
#import "ZCCorePhotoBroswe.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showImage {
    
    [ZCCorePhotoBroswe showImage:self.imageButton.imageView];
}

@end

