//
//  YHFloatContainer.h
//  YHFloatContainerView_Example
//
//  Created by chenyehong on 2022/3/9.
//  Copyright © 2022 chenyehong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHFloatContainer : UIView

/// 内部控件，距离上下左右的边距
@property (nonatomic, assign) UIEdgeInsets paddingInsets;
/// 内部控件，左右之间的距离
@property (nonatomic, assign) CGFloat itemSpacing;
/// 内部控件，行间距
@property (nonatomic, assign) CGFloat lineSpacing;
/// 内部控件集合，自定义控件需重写sizeThatFits，赋值后自动调用updateUI
@property (nonatomic, copy) NSArray <UIView*> *itemList;
/// 内部合理高度，异步更新
@property (nonatomic, assign, readonly) CGFloat contentHeight;
/// 更新内部控件布局约束
-(void)updateUI;

@end

NS_ASSUME_NONNULL_END
