//
//  MusicPlayerViewController.m
//  TestMusic
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "PlayerToolBar.h"
#import "MJExtension.h"
#import "Music.h"
#import "MusicCell.h"
#import "MusicTool.h"

@interface MusicPlayerViewController ()<UITableViewDataSource,UITableViewDelegate,PlayerToolBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSArray *musics;//音乐数据
@property(assign, nonatomic)NSInteger musicIndex;//当前播放音乐索引

@property(weak,nonatomic)PlayerToolBar *playerToolBar;//播放工具条
@end

@implementation MusicPlayerViewController

-(NSArray *)musics{
    if (!_musics) {
        _musics = [Music objectArrayWithFilename:@"songs.plist"];
    }
    
    return _musics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PlayerToolBar *toolBar = [PlayerToolBar playerToolBar];
    toolBar.bounds = self.bottomView.bounds;
    [self.bottomView addSubview:toolBar];
    
    self.playerToolBar = toolBar;//重新赋值播放工具
    self.tableView.backgroundColor = [UIColor clearColor];
    
    toolBar.delegate = self;
    /**
     *  初始化播放音乐
     */
     toolBar.playingMusic = self.musics[self.musicIndex];
    [[MusicTool sharedMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicCell *cell = [MusicCell musicCellWithTableView:tableView];
    
    Music *music = self.musics[indexPath.row];
    
    cell.music =music;

    return cell;
}

#pragma mark 播放工具条的代理
-(void)playToolBar:(PlayerToolBar *)toolbar btnClickWithType:(BtnType)btnType{
    
    switch (btnType) {
                    case BtnTypePlay:
                        NSLog(@"BtnTypePlay");
                        [[MusicTool sharedMusicTool] play];
                        break;
                    case BtnTypePause:
                        NSLog(@"BtnTypePause");
                        [[MusicTool sharedMusicTool] pause];
                        break;
                    case BtnTypePrevious:
                        NSLog(@"BtnTypePrevious");
                        [self previous];
                        break;
                    case BtnTypeNext:
                        NSLog(@"BtnTypeNext");
                    [self next];
                    break;

    }
}



-(void)next{
    
    //1.更改播放的索引
    if (self.musicIndex == self.musics.count - 1) {//最后条
        self.musicIndex = 0;
    }else{
        self.musicIndex ++;
    }
    
    
    [self playMusic];
}

-(void)previous{
    if (self.musicIndex == 0) {//第一首
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex --;
    }
    
    [self playMusic];
}
-(void)playMusic{
    //2.更改 “播放器工具条” 的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
    
    //3.重新初始化一个 "播放器"
    [[MusicTool sharedMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
    
    //4.播放self.playerToolBar.isPlaying)
    if (self.playerToolBar.isPlaying) {
        [[MusicTool sharedMusicTool] play];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.musicIndex = indexPath.row;
    [self playMusic];
}
@end
