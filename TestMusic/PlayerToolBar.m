//
//  PlayerToolBar.m
//  TestMusic
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import "PlayerToolBar.h"
#import "UIButton+CZ.h"
#import "UIImage+CZ.h"
#import "Music.h"
#import "MusicPlayerViewController.h"
#import "MusicTool.h"
#import "NSString+CZ.h"

@interface PlayerToolBar()
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;//总时间
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;//当前时间

@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
- (IBAction)playBtnClick:(id)sender;

- (IBAction)previousBtnClick:(id)sender;
- (IBAction)nextBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
- (IBAction)stopPlay:(UISlider *)sender;

- (IBAction)sliderChange:(UISlider *)sender;

- (IBAction)replay:(UISlider *)sender;

@property(strong,nonatomic)CADisplayLink *link;//定时器

@property(assign,nonatomic,getter=isDragging)BOOL dragging;//是否正在拖拽
@end


@implementation PlayerToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (IBAction)stopPlay:(UISlider *)sender {
    
    self.dragging = YES;
    [[MusicTool sharedMusicTool] pause];
    
}

- (IBAction)sliderChange:(UISlider *)sender {
    
    [MusicTool sharedMusicTool].player.currentTime = sender.value;
    
    self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:sender.value];
}

- (IBAction)replay:(UISlider *)sender {
    self.dragging = NO;
    
    if (self.isPlaying) {
    [[MusicTool sharedMusicTool]play];
    }
}

- (CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

+(instancetype)playerToolBar{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlayerToolBar" owner:nil options:nil] lastObject];
}

- (void)setPlayingMusic:(Music *)playingMusic{

    _playingMusic = playingMusic;
    
    UIImage *cicleImage = [UIImage circleImageWithName:playingMusic.singerIcon borderWidth:1.0 borderColor:[UIColor yellowColor]];
    self.singerImageView.image = cicleImage;
   
    self.musicNameLabel.text = playingMusic.name;
 
    self.singerNameLabel.text = playingMusic.singer;
    
    double duration = [MusicTool sharedMusicTool].player.duration;
    self.totalTimeLabel.text = [NSString getMinuteSecondWithSecond:duration];
    
    self.timeSlider.maximumValue = duration;
    
    self.timeSlider.value = 0;
    
    self.singerImageView.transform = CGAffineTransformIdentity;
}

- (IBAction)playBtnClick:(UIButton *)btn {
    
    self.playing = !self.playing;
    if (self.playing) {
        NSLog(@"播放音乐");
    
        [btn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];
         [self notifyDelegateWithBtnType:BtnTypePlay];
    }else{
        NSLog(@"暂停音乐");
        [btn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_click"];
        [self notifyDelegateWithBtnType:BtnTypePause];
    }
}


//上一首
- (IBAction)previousBtnClick:(id)sender {
    
    [self notifyDelegateWithBtnType:BtnTypePrevious];
    self.singerImageView.transform = CGAffineTransformIdentity;
}
//下一首
- (IBAction)nextBtnClick:(id)sender {
    [self notifyDelegateWithBtnType:BtnTypeNext];
    self.singerImageView.transform = CGAffineTransformIdentity;
}


-(void)notifyDelegateWithBtnType:(BtnType)btnType{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(playToolBar:btnClickWithType:)]) {
        [self.delegate playToolBar:self btnClickWithType:btnType];
    }
    
}


-(void)awakeFromNib{
    //设置slider 按钮的图片
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"playbar_slider_thumb"] forState:UIControlStateNormal];
    
    //开启定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)dealloc{
    
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


//更新进度条
- (void)update{
    if (self.isPlaying && self.isDragging == NO) {
        double curtentTime = [MusicTool sharedMusicTool].player.currentTime;
        
        self.timeSlider.value = curtentTime;
        
        self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:curtentTime];
        
        CGFloat angle = M_PI_4 /60;
        
        self.singerImageView.transform = CGAffineTransformRotate(self.singerImageView.transform, angle);
    }

}


@end
