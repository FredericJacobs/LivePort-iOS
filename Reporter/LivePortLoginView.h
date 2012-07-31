//
//  LivePortLoginView.h
//  LivePort
//
//  Created by Frederic Jacobs on 29/7/12.
//  GPLv3 Release GNU GENERAL PUBLIC LICENSE aka Copyleft - http://www.gnu.org/copyleft/gpl.html
//

#import <UIKit/UIKit.h>

@interface LivePortLoginView : UIView {
    UITextField *usernameField;
    UITextField *mPasswordField;
}

@property (nonatomic,retain) UITextField *usernameField;
@property (nonatomic,retain) UITextField *mPasswordField;


@end
