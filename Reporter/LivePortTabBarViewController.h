//
//  LivePortTabBarViewController.h
//  LivePort
//
//  Created by Frederic Jacobs on 28/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LivePortLoginView.h"

@interface LivePortTabBarViewController : UITabBarController<UITextFieldDelegate>{
    UIImageView *defaultView;
    LivePortLoginView *loginView;
    
}

@property (nonatomic, retain) IBOutlet LivePortLoginView *loginView;

@end
