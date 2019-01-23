#pragma once

#include <QObject>
#include <QFile>
#include <QUdpSocket>
#include <QtCore>
#include <QMap>
#include <map>

struct ConnectorWorker : QObject
{
Q_OBJECT
public:
	ConnectorWorker(){}
	int shutdownconnector;

	QString filename;
	QFile *ipFile;
	QUdpSocket *udpSocket;
	std::map<int const, QString> robotAddrMap;
	int connectedAllSocketsFlag;
	QMap<int,QString> numIP;
	QMap<QString,QString> macIP;

	QList<QString> macList;

	int gotPacketsNum;
	//QTimer* timer;

	int connectedSockets;
	int connectedRobots;
	QByteArray command;

	char dat[12];

signals:
	void receivedDatagram(QByteArray datagram);
	void receivedAddresses(QByteArray addressDatagram);
	void gotStringAddresses(QByteArray stringAddressDatagram);
	void allNeededRobotsEnabled();
	void allTasksDone();
	void robotAdded(QString);
	void sendMacs(QList<QString>);
	void sendPortList(QStringList);

public slots:
	void init();
	void start();
	void stop();
	void run(int N, QByteArray command);
	void udpProcessPendingDatagrams();
	void receiveMacArray(QString*);
	void addIp(int id, QString ip);
};
