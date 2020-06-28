//
//  CustomViewLayout.h
//  LunBo
//
//  Created by caoye on 2020/1/6.
//  Copyright © 2020 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemCenterSpace;

// 滚动到指定位置
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

// 获取分页滚动的位置
- (NSInteger)getPageIndex;

@end

NS_ASSUME_NONNULL_END
