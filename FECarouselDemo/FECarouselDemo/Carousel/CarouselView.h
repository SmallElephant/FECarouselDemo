//
//  CarouselView.h
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView

@property (nonatomic, strong) NSArray *imgList;
 //当前选中位置
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
//是否分页，默认为true
@property (nonatomic, assign) BOOL pagingEnabled;

@end
