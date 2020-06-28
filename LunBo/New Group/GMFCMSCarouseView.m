//
//  GMFCMSCarouseView.m
//  LunBo
//
//  Created by caoye on 2020/1/8.
//  Copyright © 2020 caoye. All rights reserved.
//

#import "GMFCMSCarouseView.h"
#import "GMFCMSCarouseItemView.h"

@interface GMFCMSCarouseView ()

@property (nonatomic, strong) NSMutableArray *viewsArray;

@end



@implementation GMFCMSCarouseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _viewsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setData:(NSArray *)dataArray {
    for (NSInteger i = 0; i <dataArray.count; i++) {
        GMFCMSCarouseItemView *itemView = [[GMFCMSCarouseItemView alloc] init];
        CGFloat itemW = 180;
        CGFloat itemH = 200;
        itemView.frame = CGRectMake((CGRectGetWidth(self.frame) - itemW)*0.5, (CGRectGetHeight(self.frame) - itemH)*0.5, itemW, itemH);

        [self addSubview:itemView];
        itemView.backgroundColor = dataArray[i];
        [_viewsArray addObject:itemView];


    }
}


- (void)resetViews:(NSMutableArray *)viewsArray {
    CGFloat scale = 0;
    CGFloat offsetX = 30;
    CGFloat itemW = 180;
    CGFloat itemH = 200;
    
    for (NSInteger i = 0; i < _viewsArray.count; i++) {
        UIView *itemView = _viewsArray[i];
        itemView.frame = CGRectMake((CGRectGetWidth(self.frame) - itemW)*0.5, (CGRectGetHeight(self.frame) - itemH)*0.5, itemW, itemH);

        if (i == 0) {
            CGRect rect = itemView.frame;
            rect.origin.x = (CGRectGetWidth(self.frame) - itemW)*0.5;
            itemView.frame = rect;
            [self bringSubviewToFront:itemView];
        } else if (i == 1) {
            
        } else if (i == _viewsArray.count - 1) {
            itemView.transform = CGAffineTransformMakeScale(0.8, 0.8);
//            itemView.center.x =
//            CGRect rect = itemView.frame;
//            rect.origin.x = (CGRectGetWidth(self.frame) - itemW)*0.5-offsetX;
//            itemView.frame = rect;
        } else {
            itemView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            CGRect rect = itemView.frame;
//            rect.origin.x = (CGRectGetWidth(self.frame) - itemW)*0.5 + offsetX;
            itemView.frame = rect;
        }
    }
}


@end
