//
//  CarouselCell.m
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "CarouselCell.h"

@interface CarouselCell ()

@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation CarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)update:(NSString *)imgName {
    self.imgView.image = [UIImage imageNamed:imgName];
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.layer.masksToBounds = true;
    [self addSubview:self.imgView];
}

@end
