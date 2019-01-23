#pragma once

#include <QWidget>
#include <QTimer>
#include <QKeyEvent>
#include "ui_remotecontrol.h"

class RemoteControl : public QWidget
{
	Q_OBJECT

	void closeEvent(QCloseEvent *);

public:
	explicit RemoteControl(QWidget *parent = 0);
private:
	QTimer timer;
	void keyPressEvent(QKeyEvent *key);
	void keyReleaseEvent(QKeyEvent * key);
	int keys[256];
	int key_shift;
	int effort;
private slots:
	void RC_send(void);
public slots:
	void TimerStart();
	void TimerStop();
private:
	Ui::RemoteControl ui;
signals:
	void RC_control(int left,int right,int kick,int beep, bool kickUp);
};
