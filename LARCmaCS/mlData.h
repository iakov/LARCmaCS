#pragma once

#include <iostream>
#include "engine.h"
#include "matrix.h"

typedef struct
{
	std::string	name;
	std::string file_of_matlab;
	int RULE_AMOUNT;
	int RULE_LENGTH;
	int BACK_AMOUNT;
	int BACK_LENGTH;
} RCConfig;

class MlData
{
	explicit MlData(const MlData&); // NO COPY CTOR!!! Old one was incorrect!
public:
	//MlData(){}
	~MlData();
	explicit MlData(const RCConfig &conf);

	RCConfig config;

	Engine  *ep;
	mxArray *Rule;
	mxArray *Ball;
	mxArray *Blue;
	mxArray *Yellow;
	mxArray *Back_Params;
	mxArray *Back_Amount;
	mxArray *Back_Length;
	mxArray *ballInside;
};
