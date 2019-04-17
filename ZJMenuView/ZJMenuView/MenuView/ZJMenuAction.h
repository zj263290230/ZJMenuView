//
//  ZJMenuAction.h
//  ZJMenuView
//
//  Created by zj on 2019/2/20.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJMenuAction;
typedef void(^handle)(ZJMenuAction *action);

@interface ZJMenuAction : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) handle handle;


- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image action:(handle)handle;

@end

NS_ASSUME_NONNULL_END
