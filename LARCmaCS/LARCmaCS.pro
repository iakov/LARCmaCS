#-------------------------------------------------
#
# Project created
#
#-------------------------------------------------


# use from command line:qmake -r CONFIG+=debug  CONFIG+=sanitize_thread
CONFIG *= sanitizer sanitize_undefined sanitize_leak sanitize_address
#read the global configuration file
include( ../config.pro.inc )

#where to place built objects
OBJECTS_DIR = ../build/LARCmaCS/obj$${SUFFIX_STR}

#where to place temporary moc sources
MOC_DIR = ../build/LARCmaCS/moc

#where to place auto-generated UI files
UI_DIR = ../build/LARCmaCS/ui

#where to place intermediate resource files
RCC_DIR = ../build/LARCmaCS/resources


#INCLUDEPATH += ../larcmacs-protobuf/include/

unix {
  #add google protocol buffers
  LIBS += -lprotobuf
  MATLAB_LIB_DIR = $${MATLAB_DIR}/../bin/glnxa64
  LIBS += -L$${MATLAB_LIB_DIR} -leng -lmat -lmx

  QMAKE_LFLAGS += -Wl,-rpath=$$[QT_INSTALL_LIBS] -Wl,-rpath=$$MATLAB_LIB_DIR
#  QMAKE_LFLAGS += -Wl,--disable-new-dtags
  #add opengl support
  LIBS += -lGL -lGLU

  #workaround for harfbuzz missing FT_Get_Var_Blend_Coordinates on link
  LIBS += -lfreetype
}

win32 {
  #add libs
  LIBS += -L$$PWD/../lib/ -llibprotobuf$${SUFFIX_STR} \
          -lws2_32

  LIBS += -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibeng \
          -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibmat \
          -L$${MATLAB_DIR}/lib/win32/microsoft/ -llibmx


}

QT       += core gui
QT       += network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = LARCmaCS
TEMPLATE = app


#directories of sources of the vision client

INCLUDEPATH += \
  $${SHARED_DIR}/net \
  $${SHARED_DIR}/proto/cpp \
  $${SHARED_DIR}/util \
  $${SHARED_DIR}/rfprotocol \
  $${MATLAB_DIR}/include \
  $${SHARED_DIR}/vartypes

SOURCES += main.cpp\
  $${SHARED_DIR}/net/netraw.cpp \
  $${SHARED_DIR}/net/robocup_ssl_client.cpp \
        larcmacs.cpp \
    fieldScene.cpp \
    sceneView.cpp \
    receiver.cpp \
    mainAlg.cpp \
    mlData.cpp \
    connector.cpp \
    remotecontrol.cpp \
    message.cpp \
    ipdialog.cpp \
    client.cpp \
    reference.cpp \
    sceneViewWorker.cpp \
    robot.cpp \
    receiverWorker.cpp \
    mainAlgWorker.cpp \
    connectorWorker.cpp \
    packetSSL.cpp \

HEADERS  += \
  $${SHARED_DIR}/net/netraw.h \
  $${SHARED_DIR}/net/robocup_ssl_client.h \
  $${SHARED_DIR}/net/Pipe.h \
  $${SHARED_DIR}/util/timer.h \
  $${SHARED_DIR}/util/field_default_constants.h \
  $${SHARED_DIR}/rfprotocol/rfprotocol.h \
        larcmacs.h \
    fieldScene.h \
    sceneView.h \
    packetSSL.h \
    receiver.h \
    mainAlg.h \
    mlData.h \
    connector.h \
    remotecontrol.h \
    message.h \
    ipdialog.h \
    client.h \
    reference.h \
    sceneViewWorker.h \
    receiverWorker.h \
    robot.h \
    mainAlgWorker.h \
    connectorWorker.h \

FORMS    += larcmacs.ui \
    remotecontrol.ui \
    ipdialog.ui \
    reference.ui \
