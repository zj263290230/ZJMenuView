//
//  ZJMenuAction.m
//  ZJMenuView
//
//  Created by zj on 2019/2/20.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ZJMenuAction.h"

@interface ZJMenuAction ()

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, copy, readwrite) handle handle;

@end


@implementation ZJMenuAction

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image action:(handle)handle {
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.handle = handle;
        
    }
    return self;
}

@end
