//
//  FirstViewController.h
//  Reporter
//
//  Created by Frederic Jacobs on 28/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import <UIKit/UIKit.h>

@interface MapViewController  : UIViewController <UIWebViewDelegate>{
    UIWebView *map;
}

@property (nonatomic,retain) UIWebView *map;

@end
