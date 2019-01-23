#include "sceneView.h"
#include <iostream>
#include "sceneViewWorker.h"

using namespace std;

SceneView::SceneView(){};

SceneView::~SceneView()
{
	stop();
	thread.wait(100);
	thread.terminate();
	thread.wait(100);
}

void SceneView::init()
{
	worker.moveToThread(&thread);
	cout << "sceneView init ok" << endl;
	connect(this, SIGNAL(wstart()), &worker, SLOT(start()));
	connect(this, SIGNAL(wstop()), &worker, SLOT(stop()));
#if TODO_IAKOV
	connect(&thread, SIGNAL(finished()), &worker, SLOT(deleteLater()));
#endif
}

void SceneView::start()
{
	thread.start();
	cout << "Scene view thread started" << endl;
	emit wstart();
}

void SceneView::stop()
{
	emit wstop();
}
