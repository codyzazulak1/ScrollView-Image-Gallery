//
//  ViewController.m
//  ScrollView Image Gallery
//
//  Created by Cody Zazulak on 2015-07-14.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

#import "ViewController.h"
#import "ImageDetailViewController.h"

@interface ViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView1;
@property (nonatomic) UIImageView *imageView2;
@property (nonatomic) UIImageView *imageView3;

@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer1;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer2;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer3;

@property (nonatomic) UIImage *selectedImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [self.view bounds];
    
    self.scrollView.delegate = self;
    
    //image1
    self.imageView1 = [[UIImageView alloc] initWithFrame:screenRect];
    UIImage *image1 = [UIImage imageNamed:@"Lighthouse"];
    self.imageView1.frame = CGRectMake(0,
                                       0,
                                       screenRect.size.width,
                                       screenRect.size.height);
    self.imageView1.image = image1;
    self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView1];
    self.imageView1.userInteractionEnabled = YES;
    
    
    //image2
    self.imageView2 = [[UIImageView alloc] initWithFrame:screenRect];
    UIImage *image2 = [UIImage imageNamed:@"Lighthouse-night"];
    self.imageView2.frame = CGRectMake(0,
                                       self.imageView1.frame.size.height,
                                       screenRect.size.width,
                                       screenRect.size.height);
    self.imageView2.image = image2;
    self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView2];
    self.imageView2.userInteractionEnabled = YES;
    
    
    //image3
    self.imageView3 = [[UIImageView alloc] initWithFrame:screenRect];
    UIImage *image3 = [UIImage imageNamed:@"Lighthouse-in-Field"];
    self.imageView3.frame = CGRectMake(0,
                                       self.imageView1.frame.size.height + self.imageView2.frame.size.height,
                                       screenRect.size.width,
                                       screenRect.size.height);
    self.imageView3.image = image3;
    self.imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView3];
    self.imageView3.userInteractionEnabled = YES;
    
    int sum = (self.imageView1.frame.size.height + self.imageView2.frame.size.height + self.imageView3.frame.size.height);
    
    CGRect scrollableRect = screenRect;
    scrollableRect.size.height = sum;

    [self.scrollView setContentSize:scrollableRect.size];
    
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(screenRect.size.width, sum)];
    
    self.tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    self.tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    self.tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    
    [self.imageView1 addGestureRecognizer:_tapGestureRecognizer1];
    [self.imageView2 addGestureRecognizer:_tapGestureRecognizer2];
    [self.imageView3 addGestureRecognizer:_tapGestureRecognizer3];
    
    _tapGestureRecognizer1.delegate = self;
    _tapGestureRecognizer2.delegate = self;
    _tapGestureRecognizer3.delegate = self;
    
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer {
    if (self.tapGestureRecognizer1 == recognizer) {
        self.selectedImage = self.imageView1.image;
    }
    else if (self.tapGestureRecognizer2 == recognizer) {
        self.selectedImage = self.imageView2.image;
    } else {
        self.selectedImage = self.imageView3.image;
    }
    [self performSegueWithIdentifier:@"segueToImageDetailVC" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToImageDetailVC"]) {
        UIImage* sentImage = self.selectedImage;
        
        ImageDetailViewController *controller = (ImageDetailViewController *)segue.destinationViewController;
        controller.recievedImage = sentImage;
        
        NSLog(@"Image: %@", sentImage);
    }
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"Scroll view content size: %@", NSStringFromCGSize(self.scrollView.contentSize));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
