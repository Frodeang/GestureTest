//
//  ViewController.m
//  GestureTest
//
//  Created by fankaiang  on 15/5/14.
//  Copyright (c) 2015年 fankaiang . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addGestureRecognizerForImageView:firstImageView];
    [self addGestureRecognizerForImageView:secondImageView];
    [self addGestureRecognizerForImageView:thirdImageView];
}

- (void)addGestureRecognizerForImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    // 滑动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imageView addGestureRecognizer:panGestureRecognizer];
//    长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imageView addGestureRecognizer:longPressGesture];
//    转动手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [imageView addGestureRecognizer:rotationGesture];
//    缩放手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [imageView addGestureRecognizer:pinchGesture];
    
//     UITapGestureRecognizer
//    UISwipeGestureRecognizer
    
}

- (BOOL)isFirstResponder
{
    return YES;
    
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)pan:(UIPanGestureRecognizer *)aPanGesture
{
    [self.view bringSubviewToFront:aPanGesture.view];
    
//    在使用手势时先判断当前手势的状态
//    state readOnly
    if (aPanGesture.state == UIGestureRecognizerStateBegan || aPanGesture.state == UIGestureRecognizerStateChanged) {
//        translationInView
//        在滑动时 通过translationInView方法获得滑动的距离的增量值，分别相对于父视图的坐标的x和y上的增量值
        CGPoint point = [aPanGesture translationInView:aPanGesture.view.superview];
        UIView *currentImageView = aPanGesture.view;
//        把获取的移动的增量分别叠加到当前的第一张图片的中心坐标上。
        currentImageView.center = CGPointMake(currentImageView.center.x + point.x, currentImageView.center.y + point.y);
//        重置滑动增量，以防止移动叠加
        [aPanGesture setTranslation:CGPointZero inView:self.view];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)aLongPressGesture
{
    if (aLongPressGesture.state == UIGestureRecognizerStateBegan) {
        //      创建菜单控制器对象 单例类
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        //      创建菜单项
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"重置" action:@selector(reset)];
        //      设置菜单控制器的所有的菜单项
        menuController.menuItems = [NSArray arrayWithObjects:item, nil];
        //      获得点击的位置的坐标（相对于图片视图）
        CGPoint point = [aLongPressGesture locationInView:aLongPressGesture.view];
        //      设置菜单控制器显示的位置
        [menuController setTargetRect:CGRectMake(point.x, point.y, 100, 40) inView:aLongPressGesture.view];
        
        [menuController setMenuVisible:YES animated:YES];
        [aLongPressGesture.view becomeFirstResponder];
    }
}

- (void)rotation:(UIRotationGestureRecognizer *)aRotationGesture
{
    if (aRotationGesture.state == UIGestureRecognizerStateBegan || aRotationGesture.state == UIGestureRecognizerStateChanged) {
        aRotationGesture.view.transform = CGAffineTransformRotate(aRotationGesture.view.transform, aRotationGesture.rotation);
        
        aRotationGesture.rotation = 0;
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)apinchGesture
{
    if (apinchGesture.state == UIGestureRecognizerStateBegan || apinchGesture.state == UIGestureRecognizerStateChanged) {
        apinchGesture.view.transform = CGAffineTransformScale(apinchGesture.view.transform, apinchGesture.scale, apinchGesture.scale);
        
        
        apinchGesture.scale = 1;
        //        CGAffineTransfor
    }
}

- (void)reset
{
    NSLog(@"重置重置。。。。。");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
