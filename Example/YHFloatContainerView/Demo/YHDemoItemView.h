//
//  YHDemoItemView.h
//  YHFloatContainerView_Example
//
//  Created by chenyehong on 2022/3/9.
//  Copyright © 2022 chenyehong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHDemoItemView : UIView

@property (nonatomic, strong) UIButton *btn;
+(instancetype)createWithLbTxt: (NSString*)lbTxt btnTxt: (NSString*)btnTxt;

@end

NS_ASSUME_NONNULL_END
