//
//  ZFViewController.m
//  ZFPushAnnimation
//
//  Created by xsy on 2017/5/9.
//  Copyright © 2017年 林再飞. All rights reserved.
//

#import "ZFViewController.h"
#import "ZFPushTransition.h"
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface ZFViewController ()
@property(strong,nonatomic)ZFPushTransition *push;
@end

@implementation ZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,100,kScreenWidth - 10 , 400)];
    [self.view addSubview:self.showImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    
    if(operation == UINavigationControllerOperationPush){
        return self.push;
    }else if (operation == UINavigationControllerOperationPop){
        
        self.push.type = TransitionTypePop;
        return self.push;
    }else{
        return nil;
    }
}
-(ZFPushTransition *)push{
    if (_push == nil) {
        _push = [[ZFPushTransition alloc] init];
    }
    return _push;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
