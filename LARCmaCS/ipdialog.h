#pragma once

#include <QDialog>
#include "connector.h"
#include "receiver.h"
#include "ui_ipdialog.h"

class IpDialog : public QDialog
{
	Q_OBJECT

public:
	explicit IpDialog(ConnectorWorker &worker, QWidget *parent = nullptr);

private slots:
	void on_buttonBox_accepted();
	void on_buttonBox_rejected();

private:
	Ui::IpDialog ui;
	Receiver receiver;
	Connector connector;

signals:
	void addIp(int, QString);
};
