//
//  Project.h
//  iEstimator
//
//  Created by John Wooten on 1/7/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "EstimationModel.h"


@interface Project : NSObject <NSCoding> {

	NSString *name;
	NSString *client;
	NSDate *proposedStart;
	NSDate *predictedEnd;
	float proposedDuration;
	float proposedCost;
	float actualCostValue;
	NSDate *actualStart;
	NSDate *actualEnd;
	NSMutableArray *teams;
	EstimationModel *model;
	
	
}

@property (nonatomic, retain) NSDate *proposedStart;
@property (nonatomic, retain) NSDate *predictedEnd;
@property (nonatomic, retain) NSDate *actualStart;
@property (nonatomic, retain) NSDate *actualEnd;
@property (nonatomic, retain) NSMutableArray *teams;
@property (nonatomic, retain) EstimationModel *model;

- (id) init: (NSString *)aName client: (NSString *)aClient;
- (NSString *) name;
- (void) setName:(NSString *)aName;
- (NSString *) client;
- (void) setClient:(NSString *)aClient;
- (void) setProposedStart: (NSDate *)aDate;
- (NSDate *)proposedStart;
- (NSString *)proposedStartStr;
- (NSDate *)predictedEnd;
- (NSString *)predictedEndStr;
- (void) setActualStart:(NSDate *)aDate;
- (NSDate *)actualStart;
- (NSString *)actualStartStr;
- (void)setActualEnd:(NSDate *)aDate;
- (NSDate *)actualEnd;
- (NSString *)actualEndStr;
- (float) actualDuration;
- (void) setActualCost:(NSString *)str;
- (NSString *) actualCostValue;
- (NSString *) actualCostStr;
- (float) actualCost;
- (float) percentComplete;
- (float) percentCost;
- (void) update; // use the model to update the endDate, duration, etc.
- (void) addTeam: (Team *)aTeam;
- (void) removeTeam: (Team *)aTeam;
- (void) setModel:(EstimationModel *) aModel;
- (EstimationModel *) model;
//(EstimationModel *) modelForName:(NSString *)modelName;
//(NSMutableDictionary *) models;
- (Team *) teamAtIndex:(int) index;
- (Team *) teamForName:(NSString *)teamName;
- (NSMutableArray *) teams;
- (void) print;
- (void) print: (NSMutableArray *)map;
- (void) dealloc;

@end
