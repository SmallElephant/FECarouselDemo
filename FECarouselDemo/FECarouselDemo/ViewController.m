//
//  ViewController.m
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "CarouselView.h"
#import "LTInfiniteScrollView.h"

#define NUMBER_OF_VISIBLE_VIEWS 1

@interface ViewController ()<LTInfiniteScrollViewDataSource, LTInfiniteScrollViewDelegate>

@property (strong, nonatomic) CarouselView *carouselView;

@property (strong, nonatomic) LTInfiniteScrollView *scrollView;
@property (assign, nonatomic) CGFloat viewSize;
@property (strong, nonatomic) NSMutableArray *imgList;
@property (assign, nonatomic) CGFloat scrollWidth;
@property (assign, nonatomic) CGFloat scrollHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self setupUI];
    [self setupScrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Accessors

- (CGFloat)scrollWidth {
    return 300;
}

- (CGFloat)scrollHeight {
    return 200;
}

# pragma mark - LTInfiniteScrollView dataSource
- (NSInteger)numberOfViews
{
    return [self.imgList count];
}

- (NSInteger)numberOfVisibleViews
{
    return NUMBER_OF_VISIBLE_VIEWS;
}

# pragma mark - LTInfiniteScrollView delegate
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view;
{
    
    if (index >= [self.imgList count]) {
        return nil;
    }
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollWidth, self.scrollHeight)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollWidth, self.scrollHeight)];
    imgView.image = [UIImage imageNamed:self.imgList[index]];
    [aView addSubview:imgView];
    aView.backgroundColor = [UIColor redColor];
    aView.tag = index;
    aView.layer.masksToBounds = true;
    if (index % 2 == 0) {
        aView.backgroundColor = [UIColor redColor];
    } else {
        aView.backgroundColor = [UIColor greenColor];
    }
    return aView;
}

- (void)updateView:(UIView *)view withProgress:(CGFloat)progress scrollDirection:(ScrollDirection)direction
{
    // you can appy animations duration scrolling here
    
    // scale
    CGPoint center = view.center;
    CGFloat sw = 0;
    CGFloat width = self.scrollWidth * (1.0 - sw * fabs(progress));
    CGFloat scaleY = 0.25;
    CGFloat height = self.scrollHeight * (1.0 - scaleY * (fabs(progress)));

    CGFloat sx = width / self.scrollWidth;
    CGFloat sy = height / self.scrollHeight;
    CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, sx, sy);;

    CGFloat scaleX = 0.05;
    // translate
    CGFloat translate = self.scrollWidth * scaleX * progress;
    if (progress > 1) {
        translate = self.scrollWidth * scaleX;
    } else if (progress < -1) {
        translate = -self.scrollWidth * scaleX;
    }

    // animation
    CGAffineTransform identity = CGAffineTransformIdentity;
    CGAffineTransform translateTransform = CGAffineTransformTranslate(identity, translate, 0);
    CGAffineTransform contactTransform = CGAffineTransformConcat(scaleTransform, translateTransform);
    view.center = center;
    view.transform = contactTransform;
    NSLog(@"index:%ld---progress:%f---平移位置:%f",view.tag,progress,translate);
}

- (void)scrollView:(LTInfiniteScrollView *)scrollView didScrollToIndex:(NSInteger)index {
    NSLog(@"最终滑动的结果:%ld",(long)index);
}

- (void)setupUI {
    _carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 200)];
    _carouselView.imgList = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpeg"];
    _carouselView.pagingEnabled = true;
    _carouselView.selectedIndex = 0;
    [self.view addSubview:_carouselView];
}

- (void)setupScrollView {
    self.imgList = [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpeg", nil];
    self.scrollView = [[LTInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 100, self.scrollWidth, self.scrollWidth)];
    self.viewSize = self.scrollWidth;
    [self.view addSubview:self.scrollView];
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;
    self.scrollView.maxScrollDistance = 2;
    self.scrollView.pagingEnabled = true;

    [self.scrollView reloadDataWithInitialIndex:0];
}

@end
