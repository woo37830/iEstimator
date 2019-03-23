//
//  Statistics.h
//  iEstimator
//
//  Created by John Wooten on 1/2/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Statistics : NSObject {
	int value;
	float accuracy;
	int count;
	float mean;
	float stdDev;
	double  c0, c1, c2, d1, d2, d3;
}

- (id) init: (int) value accuracy: (float) accuracy count: (int) count;
- (float) mean;
- (float) stdDev;
- (float) valueWithSigma: (float) sigma;
- (double) norminv: (double)probability mu: (double) mu sigma: (double) sigma;
@end
