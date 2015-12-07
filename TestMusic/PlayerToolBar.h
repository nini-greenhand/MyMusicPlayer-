//
//  PlayerToolBar.h
//  TestMusic
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum{
    BtnTypePlay,
    BtnTypePause,
    BtnTypePrevious,
     BtnTypeNext
    
}BtnType;

@class Music,PlayerToolBar;

@protocol PlayerToolBarDelegate <NSObject>

- (void)playToolBar:(PlayerToolBar *)toolbar btnClickWithType:(BtnType)btnType;

@end



@interface PlayerToolBar : UIView
+(instancetype)playerToolBar;

@property(assign,nonatomic,getter=isPlaying)BOOL playing;

@property(nonatomic,weak)id<PlayerToolBarDelegate> delegate;

@property(nonatomic,strong) Music *playingMusic;//当前播放的音乐
@end
