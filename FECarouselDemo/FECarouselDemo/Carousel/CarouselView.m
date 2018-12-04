//
//  CarouselView.m
//  FECarouselDemo
//
//  Created by FlyElephant on 2018/12/3.
//  Copyright © 2018年 FlyElephant. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCell.h"
#import "CarouselFlowLayout.h"

@interface CarouselView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (assign, nonatomic) CGFloat dragStartX;

@property (assign, nonatomic) CGFloat dragEndX;

@end

@implementation CarouselView

#pragma mark LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark UIScrollViewDelegate

//在不使用分页滚动的情况下需要手动计算当前选中位置 -> _selectedIndex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pagingEnabled) {return;}
    if (!_collectionView.visibleCells.count) {return;}
    if (!scrollView.isDragging) {return;}
    CGRect currentRect = _collectionView.bounds;
    currentRect.origin.x = _collectionView.contentOffset.x;
    for (CarouselCell *cell in _collectionView.visibleCells) {
        if (CGRectContainsRect(currentRect, cell.frame)) {
            NSInteger index = [_collectionView indexPathForCell:cell].row;
            if (index != _selectedIndex) {
                _selectedIndex = index;
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!_pagingEnabled) {return;}
    _dragEndX = scrollView.contentOffset.x; // 分页处理
    dispatch_async(dispatch_get_main_queue(), ^{
        [self adjustCellToCenter];
    });
}

#pragma mark CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CarouselCell";
    CarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell update:self.imgList[indexPath.row]];
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [self scrollToCenter];
}

#pragma mark Private

- (void)adjustCellToCenter {
    float dragMiniDistance = 20; // 最小滚动距离
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    [self scrollToCenter];
}

- (void)scrollToCenter {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark SetupUI

- (void)setupUI {
    CarouselFlowLayout *flowLayout = [[CarouselFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CarouselCell class] forCellWithReuseIdentifier:@"CarouselCell"];
    _collectionView.userInteractionEnabled = true;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

@end
