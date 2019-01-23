#pragma once

#include <QObject>
#include <QThread>
#include <QDebug>
#include <QSharedPointer>
#include <QFile>
#include <iostream>

#include "packetSSL.h"
#include "mlData.h"
#include "client.h"
#include "mainAlgWorker.h"

#define MAX_NUM_ROBOTS 12


struct MainAlg : public QObject
{
	Q_OBJECT

public:
	QThread thread;
	MainAlgWorker worker;

	explicit MainAlg();
	~MainAlg();

	void init();
	void start();
	void stop();

signals:
	void wstart();
	void wstop();
};
