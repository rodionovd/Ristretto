//
//  AppDelegate.m
//  Ristretto
//
//  Created by Josh Puckett on 11/20/14.
//  Copyright (c) 2014 Josh Puckett. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate
{
    AVAudioPlayer *audioPlayer;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];

    NSImage *menuIcon = [NSImage imageNamed:@"Status"];
    [menuIcon setTemplate:YES];

    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setHighlightMode:YES];
    [[self statusItem] setMenu: [self statusItemMenu]];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"murmur" ofType:@"mp3"];
    NSURL* file = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [audioPlayer prepareToPlay];
    audioPlayer.numberOfLoops = -1; //Infinite chilloop
}

- (NSMenu *)statusItemMenu {
    NSMenuItem *toggleItem = ({
        NSMenuItem *item = [NSMenuItem new];
        item.title = NSLocalizedString(@"Pour the chill", @"Status bar menu item");
        item.onStateImage = [NSImage imageNamed: @"Pause"];
        item.onStateImage.template = YES;
        item.offStateImage = [NSImage imageNamed: @"Play"];
        item.offStateImage.template = YES;
        
        item.action = @selector(coffeeshopChillTime:);
        item.state = NSOffState;
        item;
    });
    
    NSMenuItem *quitItem = ({
        NSMenuItem *item = [NSMenuItem new];
        item.title = NSLocalizedString(@"Quit", @"Status bar menu item");
        item.action = @selector(terminate:);
        item.keyEquivalent = @"q";
        item;
    });

    NSMenu *menu = [NSMenu new];
    [menu addItem: toggleItem];
    [menu addItem: [NSMenuItem separatorItem]];
    [menu addItem: quitItem];
    
    return menu;
}

- (void)coffeeshopChillTime:(id)sender {

    NSMenuItem *item = (NSMenuItem *)sender;
    
    if ([audioPlayer isPlaying]) {
        [audioPlayer pause];
        NSLog(@"Pause the chill!");
        
        item.title = NSLocalizedString(@"Pour the chill", @"Status bar menu item");
        item.state = NSOffState;
    } else {
        [audioPlayer play];
        NSLog(@"Pour the chill!");
        
        item.title = NSLocalizedString(@"Pause the chill", @"Status bar menu item");
        item.state = NSOnState;
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [[NSStatusBar systemStatusBar] removeStatusItem: self.statusItem];
}

@end
