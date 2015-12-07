//
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import "MusicTool.h"

#import "Music.h"

@interface MusicTool()



@end

@implementation MusicTool
singleton_implementation(MusicTool)

-(void)prepareToPlayWithMusic:(Music *)music{
    //创建播放器
    
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    
    //准备
    [self.player prepareToPlay];
    
    
    
}


-(void)play{
    [self.player play];
}


-(void)pause{
    [self.player pause];
}
@end
