//
//  ZFPushTransition.h
//  ZFPhotoAlbum
//
//  Created by xsy on 2017/5/9.
//  Copyright © 2017年 林再飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TransitionType){
    TransitionTypePush = 0,
    TransitionTypePop ,
};
@interface ZFPushTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(assign,nonatomic)TransitionType type;

@end
