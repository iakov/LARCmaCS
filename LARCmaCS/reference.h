#pragma once

#include <QWidget>
#include "ui_reference.h"

class Reference : public QWidget
{
	Q_OBJECT

public:
	explicit Reference(QWidget *parent = 0);
signals:
	void showReference();
private slots:
	//void on_pushButton_clicked();
private:
	Ui::Help ui;
};
