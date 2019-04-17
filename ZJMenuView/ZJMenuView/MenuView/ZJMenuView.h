//
//  ZJMenuView.h
//  ZJMenuView
//
//  Created by zj on 2019/2/20.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMenuAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJMenuView : UIView

// 菜单颜色
@property (nonatomic, strong) UIColor *menuColor;
// 显示菜单的最大数
@property (nonatomic, assign) NSInteger maxCount;
// 菜单行高
@property (nonatomic, assign) NSInteger menuItemHeight;

- (void)show;
+ (instancetype)menuWithActions:(NSArray <ZJMenuAction *>*)actions width:(CGFloat)width atPoint:(CGPoint)point;


@end

NS_ASSUME_NONNULL_END
