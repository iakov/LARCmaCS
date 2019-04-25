#include "sceneViewWorker.h"
#include <QtWidgets/QApplication>
#include <QThread>
#include <iostream>

SceneViewWorker::SceneViewWorker(){};

void SceneViewWorker::start(){
	shutdownview = false;
	cout << "sceneView worker started" << std::endl;
	//cout << "sceneView worker started" << endl;

	run();
}

void SceneViewWorker::stop()
{
	shutdownview = true;
}

void SceneViewWorker::run()
{
	while(!shutdownview){
//		  cout << "signal updateView" << endl;
		emit updateView();
		//emit updateRobots();
		QApplication::processEvents();
	 QThread::msleep(1000);
	}
}
