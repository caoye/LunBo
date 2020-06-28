//
//  MyCollectionViewCell.m
//  LunBo
//
//  Created by caoye on 2020/1/6.
//  Copyright © 2020 caoye. All rights reserved.
//

#import "MyCollectionViewCell.h"
@interface MyCollectionViewCell ()

@end

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(frame), 40)];
        _lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lable];
        _lable.backgroundColor = [UIColor lightGrayColor];
//        _lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(frame), 100)];
//        _lable1.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:_lable1];
    }
    return self;
}

@end
