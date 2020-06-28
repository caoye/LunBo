//
//  CustomViewLayout.m
//  LunBo
//
//  Created by caoye on 2020/1/6.
//  Copyright © 2020 caoye. All rights reserved.
//

#import "CustomViewLayout.h"
#import <objc/message.h>

#define INTERSPACEPARAM  0.3

@interface CustomViewLayout()

@property (nonatomic, assign) NSInteger visibleCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation CustomViewLayout

- (void)prepareLayout {
    [super prepareLayout];

    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
    _viewWidth = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = self.itemSize.width;
    self.collectionView.decelerationRate = 0.05;

    self.collectionView.contentInset = UIEdgeInsetsMake(0, _viewWidth/2, 0, - _viewWidth/2);
}

- (CGSize)collectionViewContentSize {
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake((_cellCount-1)*_itemCenterSpace +_viewWidth, CGRectGetHeight(self.collectionView.frame));
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    CGFloat centerY =  self.collectionView.contentOffset.x + self.collectionView.contentInset.left + _viewWidth / 2;
    NSInteger index = (centerY - self.collectionView.contentInset.left) / _itemCenterSpace;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((_cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    attributes.size = _itemSize;
    attributes.transform = CGAffineTransformIdentity;

    CGFloat centX = indexPath.row *_itemCenterSpace ; // item中心点
    attributes.center = CGPointMake(centX, CGRectGetHeight(self.collectionView.frame) / 2);
    
    CGFloat cY = self.collectionView.contentOffset.x + _viewWidth / 2; // 屏幕中心点
    attributes.zIndex = -ABS(centX - cY); // 当前item和屏幕中心点的距离
    CGFloat delta = centX - cY;
    if (delta > 0 && delta < _itemCenterSpace*2) {
        attributes.alpha = 1- delta *(1)/(_itemCenterSpace*2);
    } else if (delta < 0 && ABS(delta) < _itemCenterSpace*2) {
        attributes.alpha = 1- ABS(delta) *(1)/(_itemCenterSpace*2);
    } else if (delta == 0) {
        attributes.alpha = 1;
    } else {
        attributes.alpha = 0;
    }
    attributes.transform = CGAffineTransformMakeScale(1 - ABS(delta) *(0.2)/_itemCenterSpace, 1- ABS(delta) *(0.2)/_itemCenterSpace);
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    [self.collectionView layoutSubviews];
    [self.collectionView setContentOffset:CGPointMake(self.itemCenterSpace *index - self.collectionView.contentInset.left, 0) animated:animated];
}

- (NSInteger)getPageIndex {
    NSInteger pageIndex = (self.collectionView.contentOffset.x + self.collectionView.contentInset.left) / self.itemCenterSpace;

    CGFloat offsetX = self.collectionView.contentOffset.x + self.collectionView.contentInset.left - pageIndex * self.itemCenterSpace;

    NSInteger currentPage;
    if (offsetX > 0 && offsetX < self.itemCenterSpace/2) { // 右滑，没超过一半
        currentPage = pageIndex;
    } else if (offsetX > 0 && offsetX > self.itemCenterSpace/2) { // 右滑，超过一半
        currentPage = pageIndex + 1;
    } else if (offsetX <0 && ABS(offsetX) < self.itemCenterSpace/2) { // 左滑，没超过一半
        currentPage = pageIndex;
    } else if (offsetX < 0 && ABS(offsetX) > self.itemCenterSpace/2) { // 左滑，超过一半
        currentPage = pageIndex - 1;
    } else {
        currentPage = pageIndex;
    }

    return currentPage;
}

@end
