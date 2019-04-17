//
//  ZJMenuView.m
//  ZJMenuView
//
//  Created by zj on 2019/2/20.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ZJMenuView.h"

@interface ZJMenuViewItemCell : UITableViewCell

@property (nonatomic, assign) BOOL isShowSeparator;
@property (nonatomic, strong) UIColor *sepColor;

@end

@implementation ZJMenuViewItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isShowSeparator = YES;
        self.sepColor = [UIColor lightGrayColor];
    }
    return self;
}


- (void)setSepColor:(UIColor *)sepColor {
    _sepColor = sepColor;
    [self setNeedsDisplay];
}

- (void)setIsShowSeparator:(BOOL)isShowSeparator {
    _isShowSeparator = isShowSeparator;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (!self.isShowSeparator) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5)];
    [self.sepColor setFill];
    
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1.0];
    [path closePath];
}

@end


@interface ZJMenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGPoint refPoint;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@end


@implementation ZJMenuView
+ (instancetype)menuWithActions:(NSArray<ZJMenuAction *> *)actions width:(CGFloat)width atPoint:(CGPoint)point {
    ZJMenuView *menu = [[ZJMenuView alloc] initWithActions:actions width:width atPoint:point];
    return menu;
}


- (instancetype)initWithActions:(NSArray <ZJMenuAction *>*)actions width:(CGFloat)width atPoint:(CGPoint)point {
    self = [super init];
    if (self) {
        self.actions = [actions copy];
        self.menuWidth = width;
        self.refPoint = point;
        
        [self p_defaultSetting];
        [self p_setupSubViews];
    }
    return self;
}


- (void)show {
    
}

#pragma mark - action
- (void)dismiss {
    
}


#pragma mark - tableView datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJMenuViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJMenuViewItemCell" forIndexPath:indexPath];
    
    ZJMenuAction *action = self.actions[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = action.title;
    cell.imageView.image = action.image;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZJMenuAction *action = self.actions[indexPath.row];
    if (action.handle) {
        action.handle(action);
    }
}


#pragma mark - private
- (void)p_setupSubViews {
    
    [self p_calculateFrame];
    
    [self addSubview:self.contentView];
}

- (void)p_defaultSetting {
    self.alpha = 0.0;
    [self p_defaultShadow];
    
    
}

- (void)p_defaultShadow {

}

- (void)p_calculateFrame {
    
}

- (void)p_setUpMaskLayer {
    
}

#pragma mark - setter && getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = [UIScreen mainScreen].bounds;
        _bgView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = self.actions.count > self.maxCount;
        _tableView.rowHeight = self.menuItemHeight;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ZJMenuViewItemCell class] forCellReuseIdentifier:@"ZJMenuViewItemCell"];
    }
    return _tableView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = self.menuColor;
        _contentView.layer.masksToBounds = YES;
        [_contentView addSubview:self.tableView];
    }
    return _contentView;
}

@end





