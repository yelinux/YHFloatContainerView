//
//  YHDemoItemView.m
//  YHFloatContainerView_Example
//
//  Created by chenyehong on 2022/3/9.
//  Copyright © 2022 chenyehong. All rights reserved.
//

#import "YHDemoItemView.h"

@interface YHDemoItemView()

@property (nonatomic, strong) UILabel *lb;

@end

@implementation YHDemoItemView

+(instancetype)createWithLbTxt: (NSString*)lbTxt btnTxt: (NSString*)btnTxt{
    YHDemoItemView *view = [YHDemoItemView new];
    view.lb.text = lbTxt;
    [view.btn setTitle:btnTxt forState:UIControlStateNormal];
    return view;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.lb];
        [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.bottom.offset(0);
        }];
        
        [self addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.offset(0);
            make.left.mas_equalTo(self.lb.mas_right).offset(0);
        }];
        self.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 15;
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size{
    [self.lb setPreferredMaxLayoutWidth:size.width];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(size.width);
    }];
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

// Mark - getter
-(UILabel *)lb{
    if (!_lb) {
        _lb = [UILabel new];
        _lb.textColor = UIColor.grayColor;
        _lb.numberOfLines = 0;
        _lb.font = [UIFont systemFontOfSize:12];
    }
    return _lb;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton new];
        [_btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    }
    return _btn;
}

@end
