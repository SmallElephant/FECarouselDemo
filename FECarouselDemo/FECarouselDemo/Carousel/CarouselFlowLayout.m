//
//  CarouselFlowLayout.m
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "CarouselFlowLayout.h"

@implementation CarouselFlowLayout

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

//设置缩放动画
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//
//    //扩大控制范围，防止出现闪屏现象
//    CGRect bigRect = rect;
//    bigRect.size.width = rect.size.width + 2*[self cellWidth];
//    bigRect.origin.x = rect.origin.x - [self cellWidth];
//
//    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
//    //屏幕中线
//    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
//    NSLog(@"偏移量:%f---宽度:%f---居中位置:%f",self.collectionView.contentOffset.x,self.collectionView.bounds.size.width,centerX);
//    //刷新cell缩放
//    for (UICollectionViewLayoutAttributes *attributes in arr) {
//
//        CGFloat distance = fabs(attributes.center.x - centerX);
//        NSLog(@"属性位置:%f---距离之差:%f",attributes.center.x,distance);
//        //移动的距离和屏幕宽度的的比例
//        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
//        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
//        CGFloat scale = fabs(cos(apartScale * M_PI/4));
//        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
//        attributes.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//    return arr;
//}

#pragma mark -
#pragma mark 配置方法

//卡片宽度
- (CGFloat)cellWidth {
    return 300;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return 0;
}

//最小纵向间距,卡片间隔
- (CGFloat)minimumLineSpacing {
    return 0;
}
//cell大小
- (CGSize)itemSize {
    return CGSizeMake([self cellWidth], 200);
}

//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

@end
