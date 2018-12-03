//
//  ViewController.m
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "CarouselView.h"

@interface ViewController ()

@property (strong, nonatomic) CarouselView *carouselView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    _carouselView = [[CarouselView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 200)];
    _carouselView.imgList = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpeg"];
    _carouselView.pagingEnabled = false;
    _carouselView.selectedIndex = 0;
    [self.view addSubview:_carouselView];
}


@end
