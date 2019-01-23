#include "mlData.h"
#include <memory.h>

MlData::MlData(const RCConfig &conf)
{
	config = conf;

	Ball         = mxCreateDoubleMatrix(1, 3, mxREAL);
	Blue         = mxCreateDoubleMatrix(12, 4, mxREAL);
	Yellow       = mxCreateDoubleMatrix(12, 4, mxREAL);
	Rule         = mxCreateDoubleMatrix(config.RULE_LENGTH, config.RULE_AMOUNT, mxREAL);
	Back_Params  = mxCreateDoubleMatrix(config.BACK_LENGTH, config.BACK_AMOUNT, mxREAL);
	Back_Amount  = mxCreateDoubleMatrix(1, 1, mxREAL);
	Back_Length  = mxCreateDoubleMatrix(1, 1, mxREAL);
	ballInside   = mxCreateDoubleScalar(0);
}

MlData::~MlData(){
#if TODO_IAKOV
	mxDestroyArray(Ball       );Ball       = nullptr;
	mxDestroyArray(Blue       );Blue       = nullptr;
	mxDestroyArray(Yellow     );Yellow     = nullptr;
	mxDestroyArray(Rule       );Rule       = nullptr;
	mxDestroyArray(Back_Params);Back_Params= nullptr;
	mxDestroyArray(Back_Amount);Back_Amount= nullptr;
	mxDestroyArray(Back_Length);Back_Length= nullptr;
	mxDestroyArray(ballInside );ballInside = nullptr;
#endif
}
