#pragma once

#include <iostream>
#include <QObject>
#include <QThread>
#include <QSharedPointer>

#include "packetSSL.h"
#include "robocup_ssl_client.h"

#include "receiverWorker.h"
struct Receiver : public QObject
{
	Q_OBJECT
public:
	QThread thread;
	ReceiverWorker worker;

	Receiver();
	~Receiver();

	void init();
	void start();
	void stop();

signals:
	void wstart();
	void wstop();
};
