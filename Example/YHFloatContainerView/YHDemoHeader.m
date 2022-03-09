//
//  YHDemoHeader.m
//  YHFloatContainerView_Example
//
//  Created by chenyehong on 2022/3/9.
//  Copyright © 2022 chenyehong. All rights reserved.
//

#import "YHDemoHeader.h"

@implementation YHDemoHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *lb = [UILabel new];
        lb.textColor = UIColor.blackColor;
        lb.backgroundColor = UIColor.lightGrayColor;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"控件从左到右自动换行布局";
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

@end
