//
//  Statistics.m
//  iEstimator
//
//  Created by John Wooten on 1/2/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "Statistics.h"


@implementation Statistics

- (id) init: (int) ii accuracy: (float) x count: (int) k	{
	[super init];
	c0 = 2.515517f;
	c1 = 0.802853f;
	c2 = 0.010328f;
	
	d1 = 1.432788f;
	d2 = 0.189269f;
	d3 = 0.001308f;
	value = ii;
	accuracy = x;
	count = k;
	unsigned long seed = [NSDate timeIntervalSinceReferenceDate];
	srandom(seed); // seed the random number generator
	double z = 0.0f;
	double z2 = 0.0f;
	int i = 0;
	for( i=0; i<count; i++ )	{
		int ran = random() % 1000;
		double x = ((double)ran)/1000.0f;
		double y = [self norminv: x mu: (float)value sigma: ((float)value)*accuracy];
		//printf("random number is %3.2f and norminv is %3.2f\n", x, y);
		z += y;
		z2 += y * y;
	}
	mean = z / count;
	stdDev = sqrt(z2/count - mean*mean);
	//printf("\nStatistics for %i with accuracy %3.2f, mean = %3.2f, stdDev = %3.2f\n", value, accuracy, mean, stdDev);
	return self;
}

- (double) norminv: (double)probability mu: (double) mu sigma: (double) sigma	{
	double x, p, t, q;
	q = probability;
	if( q == 0.5 )	{
		return mu;
	} else	{
		q = 1.0f - q;
		if(( q > 0.0f && q < 0.5f ))	{
			p = q;
		} else	{
			if( q == 1.0f ) {
				p = 1.0f - 0.9999999;
			} else	{
				p = 1.0f - q;
			}
		}
		
		t = sqrt(log(1.0f / (p*p) ) );
		
		
		x = t - (c0 + c1*(t + c2*t))/(1.0f + t*(d1 + t*( d2 + t*d3)));
		if( q > 0.5f )	{
			x = -1.0f * x;
		}
	}
	return (x*sigma) + mu;
}

- (float) mean	{
	return mean;
}

- (float) stdDev	{
	return stdDev;
}

- (float) valueWithSigma: (float) sigma	{
	//printf("Statistics returning value with sigma %3.2f of %3.2f\n", sigma, mean+sigma*stdDev);
	return mean + sigma * stdDev;
}

@end
