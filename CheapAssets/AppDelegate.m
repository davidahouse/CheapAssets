//
//  AppDelegate.m
//  CheapAssets
//
//  Created by David House on 9/18/14.
//  Copyright (c) 2014 RandomAccident. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()

#pragma mark - IBOutlets
@property (weak) IBOutlet NSColorWell *backgroundColor;
@property (weak) IBOutlet NSColorWell *foregroundColor;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *initialsLabel;


@end

@implementation AppDelegate

#pragma mark - App Lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.backgroundColor.color = [NSColor blueColor];
    self.foregroundColor.color = [NSColor yellowColor];
}

#pragma mark - IBActions

- (IBAction)generateAssets:(id)sender {
    
    // Grab the path to where the user wants to output
    // the files.
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    if ([panel runModal] != NSFileHandlingPanelOKButton) return;
    NSURL *outputPath = [[panel URLs] lastObject];
    
    // Now create the app icons
    [self generateAppIconOfSize:CGSizeMake(180, 180) fontSize:50.0 path:outputPath name:@"AppIcon@3x.png"];
    [self generateAppIconOfSize:CGSizeMake(120, 120) fontSize:44.0 path:outputPath name:@"AppIcon@2x.png"];
    [self generateAppIconOfSize:CGSizeMake(76, 76) fontSize:30.0 path:outputPath name:@"AppIcon~iPad.png"];
    [self generateAppIconOfSize:CGSizeMake(152, 152) fontSize:44.0 path:outputPath name:@"AppIcon~iPad@2x.png"];
    [self generateAppIconOfSize:CGSizeMake(1024, 1024) fontSize:240.0 path:outputPath name:@"AppStoreIcon.png"];
    [self generateAppIconOfSize:CGSizeMake(120, 120) fontSize:36.0 path:outputPath name:@"AppIcon-Spotlight@3x.png"];
    [self generateAppIconOfSize:CGSizeMake(80, 80) fontSize:30.0 path:outputPath name:@"AppIcon-Spotlight@2x.png"];
    [self generateAppIconOfSize:CGSizeMake(40, 40) fontSize:20.0 path:outputPath name:@"AppIcon-Spotlight@1x.png"];
    [self generateAppIconOfSize:CGSizeMake(87, 87) fontSize:36.0 path:outputPath name:@"AppIcon-Settings@3x.png"];
    [self generateAppIconOfSize:CGSizeMake(58, 58) fontSize:30.0 path:outputPath name:@"AppIcon-Settings@2x.png"];
    [self generateAppIconOfSize:CGSizeMake(29, 29) fontSize:20.0 path:outputPath name:@"AppIcon-Settings@1x.png"];

    // Finally the default screens
    [self generateDefaultImageOfSize:CGSizeMake(1242, 2208) fontSize:58.0 path:outputPath name:@"Default-736h@3x.png"];
    [self generateDefaultImageOfSize:CGSizeMake(750, 1334) fontSize:48.0 path:outputPath name:@"Default-667h@2x.png"];
    [self generateDefaultImageOfSize:CGSizeMake(640, 1136) fontSize:38.0 path:outputPath name:@"Default-568h@2x.png"];
    [self generateDefaultImageOfSize:CGSizeMake(640, 960) fontSize:28.0 path:outputPath name:@"Default@2x.png"];
    [self generateDefaultImageOfSize:CGSizeMake(320, 480) fontSize:18.0 path:outputPath name:@"Default.png"];
}

- (void)generateAppIconOfSize:(CGSize)size fontSize:(CGFloat)fontSize path:(NSURL *)outputpath name:(NSString *)filename
{
    NSView *backerView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    backerView.wantsLayer = YES;
    backerView.layer.backgroundColor = self.backgroundColor.color.CGColor;
    
    NSFont *initialsFont = [NSFont systemFontOfSize:fontSize];
    
    NSTextView *initials = [[NSTextView alloc] initWithFrame:NSMakeRect(0, (size.height - fontSize) / 2, size.width, fontSize)];
    initials.font = initialsFont;
    initials.alignment = NSCenterTextAlignment;
    initials.textColor = self.foregroundColor.color;
    [initials setString:self.initialsLabel.stringValue];
    initials.backgroundColor = [NSColor clearColor];
    [backerView addSubview:initials];
    
    [self saveToPng:backerView path:outputpath name:filename];
}

- (void)generateDefaultImageOfSize:(CGSize)size fontSize:(CGFloat)fontSize path:(NSURL *)outputpath name:(NSString *)filename
{
    NSView *backerView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, size.width, size.height)];
    backerView.wantsLayer = YES;
    backerView.layer.backgroundColor = self.backgroundColor.color.CGColor;
    
    NSFont *titleFont = [NSFont systemFontOfSize:fontSize];
    
    NSTextView *title = [[NSTextView alloc] initWithFrame:NSMakeRect(0, (size.height - fontSize) / 2, size.width, fontSize)];
    title.font = titleFont;
    title.alignment = NSCenterTextAlignment;
    title.textColor = self.foregroundColor.color;
    [title setString:self.titleLabel.stringValue];
    title.backgroundColor = [NSColor clearColor];
    [backerView addSubview:title];
    
    [self saveToPng:backerView path:outputpath name:filename];
}

- (void)saveToPng:(NSView *)view path:(NSURL *)path name:(NSString *)name
{
    NSBitmapImageRep *bitmapImage = [view bitmapImageRepForCachingDisplayInRect:view.bounds];
    [view cacheDisplayInRect:view.bounds toBitmapImageRep:bitmapImage];
    
    NSData *pngData = [bitmapImage representationUsingType:NSPNGFileType properties:nil];
    NSURL *finalPath = [path URLByAppendingPathComponent:name];
    [pngData writeToURL:finalPath atomically:YES];
}

@end
