#include "connector.h"

#include <stdlib.h>
#include <iostream>
#include <QMap>

Connector::Connector() {}

Connector::~Connector()
{
	stop();
	thread.wait(100);
	thread.terminate();
	thread.wait(100);
}

void Connector::init()
{
	worker.moveToThread(&thread);
	qDebug() << "Init connector ok";
	connect(this, SIGNAL(wstart()), &worker, SLOT(start()));
	connect(this, SIGNAL(wstop()), &worker, SLOT(stop()));
#if TODO_IAKOV
	connect(&thread, SIGNAL(finished()), &worker, SLOT(deleteLater()));
#endif
}

void Connector::start()
{
	thread.start();
	thread.setPriority(QThread::HighestPriority);
	qDebug() << "Connector thread start";
	emit wstart();
}

void Connector::stop()
{
	emit wstop();
}
