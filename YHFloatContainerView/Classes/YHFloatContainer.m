//
//  YHFloatContainer.m
//  YHFloatContainerView_Example
//
//  Created by chenyehong on 2022/3/9.
//  Copyright © 2022 chenyehong. All rights reserved.
//

#import "YHFloatContainer.h"

@implementation YHFloatContainer

-(void)setItemList:(NSArray<UIView *> *)items{
    _itemList = items;
    [self updateUI];
}

-(void)updateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (UIView *itemView in self.itemList) {
            [self addSubview:itemView];
            itemView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        UIView *lastView = nil;
        CGFloat lastMaxX = 0;
        CGFloat lastSizeHeight = 0;
        CGFloat maxY = 0;
        CGFloat contentWidth = self.bounds.size.width - self.paddingInsets.left - self.paddingInsets.right;
        for (UIView *itemView in self.itemList) {
            CGSize size = [itemView sizeThatFits:CGSizeMake(contentWidth, CGFLOAT_MAX)];
            if (lastView == nil) {
                [NSLayoutConstraint activateConstraints:@[
                    [itemView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.paddingInsets.left],
                    [itemView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.paddingInsets.top],
                    [itemView.widthAnchor constraintEqualToConstant:size.width],
                    [itemView.heightAnchor constraintEqualToConstant:size.height],
                ]];
                lastMaxX = self.paddingInsets.left + size.width;
                maxY = self.paddingInsets.top + size.height;
            } else {
                if (lastMaxX + self.itemSpacing + size.width > self.paddingInsets.left + contentWidth) {
                    [NSLayoutConstraint activateConstraints:@[
                        [itemView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.paddingInsets.left],
                        [itemView.topAnchor constraintEqualToAnchor:self.topAnchor constant:maxY + self.lineSpacing],
                        [itemView.widthAnchor constraintEqualToConstant:size.width],
                        [itemView.heightAnchor constraintEqualToConstant:size.height],
                    ]];
                    lastMaxX = self.paddingInsets.left + size.width;
                    maxY += self.lineSpacing + size.height;
                } else {
                    [NSLayoutConstraint activateConstraints:@[
                        [itemView.leftAnchor constraintEqualToAnchor:lastView.rightAnchor constant:self.itemSpacing],
                        [itemView.topAnchor constraintEqualToAnchor:lastView.topAnchor constant:0],
                        [itemView.widthAnchor constraintEqualToConstant:size.width],
                        [itemView.heightAnchor constraintEqualToConstant:size.height],
                    ]];
                    lastMaxX += self.itemSpacing + size.width;
                    if (size.height > lastSizeHeight) {
                        maxY += (size.height - lastSizeHeight);
                    }
                }
            }
            lastView = itemView;
            lastSizeHeight = size.height;
        }
        self->_contentHeight = maxY + self.paddingInsets.bottom;
        [self invalidateIntrinsicContentSize];
    });
}

-(CGSize)intrinsicContentSize{
    return CGSizeMake(self.bounds.size.width, _contentHeight);
}

@end
