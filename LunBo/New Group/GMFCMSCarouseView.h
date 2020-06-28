//
//  GMFCMSCarouseView.h
//  LunBo
//
//  Created by caoye on 2020/1/8.
//  Copyright © 2020 caoye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMFCMSCarouseView : UIView

- (void)setData:(NSArray *)dataArray;
- (void)resetViews:(NSMutableArray *)viewsArray;

@end

NS_ASSUME_NONNULL_END
