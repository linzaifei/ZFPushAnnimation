//
//  ZFPushTransition.m
//  ZFPhotoAlbum
//
//  Created by xsy on 2017/5/9.
//  Copyright © 2017年 林再飞. All rights reserved.
//

#import "ZFPushTransition.h"
#import "ZFViewController.h"
#import "ViewController.h"
#import "ZFCollectionViewCell.h"

@implementation ZFPushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    switch (self.type) {
        case TransitionTypePush:
            [self zf_pushAnnimationTransition:transitionContext];
            break;
        case TransitionTypePop:
            [self zf_popAnnimationTransition:transitionContext];
            break;
            
        default:
            break;
    }    
}


/**
 push动画

 @param transitionContext <#transitionContext description#>
 */
-(void)zf_pushAnnimationTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    ZFViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    //私有方法获取方法
    UICollectionView *collectionView = [fromVC valueForKey:@"collectionView"];
    ZFCollectionViewCell *cell = (ZFCollectionViewCell *)[collectionView cellForItemAtIndexPath:toVC.indexPath];
    
    //创建一个View的截图 把原来的view隐藏
    UIView *snapshotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    //获取这个假视图在toView上的位置
    //这边必须使用 toVC.sourceView  不能使用snapshotView 测试
    snapshotView.frame = [cell.imageView convertRect:cell.imageView.frame toView:containerView];
    //设置控制器的位置
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    //添加到容器中
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshotView];
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
        snapshotView.frame = toVC.showImageView.frame;
        toVC.view.alpha = 1;

    } completion:^(BOOL finished) {
        if (finished) {
            snapshotView.hidden = YES;
            toVC.showImageView.image = cell.imageView.image;
            [transitionContext completeTransition:YES];
        }

    }];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
//    } completion:^(BOOL finished) {
//    }];

}
-(void)zf_popAnnimationTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    ZFViewController *toVC = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    //私有方法获取方法
    UICollectionView *collectionView = [fromVC valueForKey:@"collectionView"];
    ZFCollectionViewCell *cell = (ZFCollectionViewCell *)[collectionView cellForItemAtIndexPath:toVC.indexPath];
    
    //创建一个View的截图 把原来的view隐藏
    UIView *snapshotView = [toVC.showImageView snapshotViewAfterScreenUpdates:NO];
    //获取这个假视图在toView上的位置
    //这边必须使用 toVC.sourceView  不能使用snapshotView 测试
    snapshotView.frame = [toVC.showImageView convertRect:toVC.showImageView.frame toView:containerView];
    //设置控制器的位置
//    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
//    toVC.view.alpha = 0;
    //添加到容器中
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshotView];
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
        snapshotView.frame = [cell.imageView convertRect:cell.imageView.frame toView:containerView];
        toVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            snapshotView.hidden = YES;
            //            toVC.showImageView.image = cell.imageView.image;
            [transitionContext completeTransition:YES];
        }
    }];
    
}



@end
