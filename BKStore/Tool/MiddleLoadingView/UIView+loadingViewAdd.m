/**
 -  UIView+loadingViewAdd.m
 -  TWBK
 -  Created by calvin_tse on 2017/5/6.
 -  Copyright © 2017年 com.mobile-kingdom.bkapps. All rights reserved.
 -  说明:该UIView分类用于提供快速显示自定义loading视图的方法和移除的方法
 -  样式为两种,"踩单车"或者"地球转"
 -  需要注意,当样式为"踩单车"且传入的文字信息为空时,则默认显示"努力加载中..."
 */

#import "UIView+loadingViewAdd.h"

@implementation UIView (loadingViewAdd)
/**
 添加loading视图(如果传入的样式为单车且文字为nil,则会默认显示"努力加载中...",其余情况则根据传入的文字信息进行显示)
 
 @param type 样式(踩单车或者地球转)
 @param transparent 是否需要透明效果
 @param title 显示的文字内容(默认为"努力加载中...")
 */
- (void)showLoadingViewWithType:(MiddleLoadingType)type
                withTransparent:(BOOL)transparent
                      withTitle:(NSString *)title {
    MiddleLoadingView *middleLoadingView = [self setupLoadingViewWithType:type withTransparent:transparent withTitle:title];
    middleLoadingView.frame = self.bounds;
}


/**
 添加loading视图(如果传入的样式为单车且文字为nil,则会默认显示"努力加载中...",其余情况则根据传入的文字信息进行显示)
 
 @param type 样式(踩单车或者地球转)
 @param transparent 是否需要透明效果
 @param title 显示的文字内容(默认为"努力加载中...")
 @param loadingViewBlock 该block用来回传loadingView,外部一般实现loadFailView的约束
 */
- (void)showLoadingViewWithType:(MiddleLoadingType)type
                withTransparent:(BOOL)transparent
                      withTitle:(NSString *)title
           withLoadingViewBlock:(void(^)(MiddleLoadingView *loadingView))loadingViewBlock {
    MiddleLoadingView *middleLoadingView = [self setupLoadingViewWithType:type withTransparent:transparent withTitle:title];
    if (loadingViewBlock) {
        loadingViewBlock(middleLoadingView);
    }
}


/**
 内部使用的方法,用来快速创建loading视图

 @param type 样式(踩单车或者地球转)
 @param transparent 是否需要透明效果
 @param title 显示的文字内容(默认为"努力加载中...")
 @return loading视图
 */
- (MiddleLoadingView *)setupLoadingViewWithType:(MiddleLoadingType)type
                                withTransparent:(BOOL)transparent
                                      withTitle:(NSString *)title {
    // 创建loading视图,并添加到当前视图
    MiddleLoadingView *middleLoadingView = [MiddleLoadingView middleLoadingView];
    [self addSubview:middleLoadingView];
    // 设置是否需要透明
    middleLoadingView.isTransparent = transparent;
    
    // 设置样式(踩单车\地球转)
    middleLoadingView.type = type;
    // 如果传入的文字内容为空,且样式为踩单车,则文字内容默认显示为"努力加载中"
    if (!title && (MiddleLoadingTypeBike == type)) {
        middleLoadingView.title = @"努力加载中...";
    } else {
        middleLoadingView.title = title;
    }
    return middleLoadingView;
}


/**
 移除loading视图
 */
- (void)removeLoadingView {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MiddleLoadingView class]]) {
            [view removeFromSuperview];
        }
    }
}


/**
 显示加载失败视图
 
 @param completion 点击加载失败视图时执行的回调.
 */
- (void)showLoadFailViewWithCompletion:(emptyBlock)completion {
    LoadFailView *loadFailView = [[LoadFailView alloc] initWithCompletion:completion];
    [self addSubview:loadFailView];
    // 添加到哪个父视图,就和该父视图的位置尺寸相同
    loadFailView.frame = self.bounds;
}


/**
 显示加载失败视图(备用API)
 
 @param completion 点击加载失败视图时执行的回调
 @param loadFailViewBlock 该block用来回传loadFailView,外部一般实现loadFailView的约束
 */
- (void)showLoadFailViewWithCompletion:(emptyBlock)completion
                 withLoadFailViewBlock:(void(^)(LoadFailView* loadFailView))loadFailViewBlock {
    LoadFailView *loadFailView = [[LoadFailView alloc] initWithCompletion:completion];
    [self addSubview:loadFailView];
    if (loadFailViewBlock) {
        loadFailViewBlock(loadFailView);
    }
}


/**
 移除加载失败视图
 */
- (void)removeLoadFailView {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LoadFailView class]]) {
            [view removeFromSuperview];
        }
    }
}
@end
