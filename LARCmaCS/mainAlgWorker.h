#pragma once

#include <QObject>
#include "packetSSL.h"
#include "mlData.h"
#include "client.h"
#include <time.h>       /* clock_t, clock(), CLOCKS_PER_SEC */

#define MAX_NUM_ROBOTS 12

struct MainAlgWorker : public QObject
{
	Q_OBJECT
	clock_t timer,timer_s,timer_m,timer_max;
	int Time_count;
	bool Send2BT[MAX_NUM_ROBOTS];
	Client client;
	bool isPause;
	double mIsBallInside;

public:
	MainAlgWorker();
	~MainAlgWorker();

signals:
	void sendToConnector(int N,QByteArray command);
#if 0
	void sendToBTtransmitter(char * message);
#endif
	void mainAlgFree();
	void StatusMessage(QString message);
	void UpdatePauseState(QString message);

public slots:

	void start();
	void Send2BTChangeit(bool *send2BT_);
	void stop();
	void run(PacketSSL packetssl);
	void Pause();
	void run_matlab();
	void stop_matlab();
	void EvalString(QString s);
	void changeBallStatus(bool ballStatus);

private:
	void init();
	char m_buffer[256]; // matlab buffer
	MlData fmldata;
	bool fmtlab;
	bool shutdowncomp;
	bool pause;
};
