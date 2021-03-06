//
//  GVCreateGroopController.h
//  sdkm
//
//  Created by Mobile on 16.12.18.
//  Copyright © 2018 BMA. All rights reserved.
//

#import "GVBaseNavController.h"
#import "GVCircleImageView.h"

typedef enum : NSUInteger {
    CREATE_GROOP_FROM_MY_GROOPS = 100,
    CREATE_GROOP_FROM_START,
    CREATE_GROOP_FROM_GROOP_DETAIL,
} GVCreateGroopViewType;

@protocol GVCreateGroopControllerDelegate <NSObject>
@optional
- (void)didSelectParticipant:(GVUser *)user;
// ... other methods here
@end

//NS_ASSUME_NONNULL_BEGIN

@interface GVCreateGroopController : GVBaseNavController

@property GVCreateGroopViewType viewType;
@property (nonatomic, weak) id <GVCreateGroopControllerDelegate> delegate;

#pragma mark - Constraints

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomViewHeight;

@end

//NS_ASSUME_NONNULL_END
