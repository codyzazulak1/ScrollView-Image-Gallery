//
//  ImageDetailViewController.m
//  ScrollView Image Gallery
//
//  Created by Cody Zazulak on 2015-07-14.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "ViewController.h"

@interface ImageDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.scrollView.delegate = self;
    NSLog(@"Image: %@", self.recievedImage);
    
    self.imageView.image = self.recievedImage;
    [self.scrollView addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    
    //works on device
    self.scrollView.scrollEnabled = YES;
    self.scrollView.minimumZoomScale=0.3;
    self.scrollView.maximumZoomScale=2.0;
    [self.scrollView setContentSize:CGSizeMake(100, 100)];
    self.scrollView.delegate=self;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
