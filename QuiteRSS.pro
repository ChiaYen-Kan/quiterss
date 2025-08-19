# VCS revision info
REVFILE = src/VersionRev.h
QMAKE_DISTCLEAN += $$REVFILE
APPLICATION_NAME="QuiteRss"
ORGANIZATION_NAME="QuiteRss"
PROJECT_NAME=quiterss

exists(.git) {
  VERSION_REV = $$system(git rev-list --count HEAD)
  count(VERSION_REV, 1) {
      VERSION_REV = $$VERSION_REV
      VERSION_HASH = \"$$system(git rev-parse --short HEAD)\"
  } else {
    VERSION_REV = 0
    VERSION_HASH = \"\"
  }
  !build_pass:message(VCS revision: $$VERSION_REV VCS short hash:$$VERSION_HASH)

  os2|win32 {
    system(echo $${LITERAL_HASH}define APPLICATION_NAME $$APPLICATION_NAME > $$REVFILE)
    system(echo $${LITERAL_HASH}define ORGANIZATION_NAME $$ORGANIZATION_NAME >> $$REVFILE)
    system(echo $${LITERAL_HASH}define VCS_REVISION $$VERSION_REV >> $$REVFILE)
    system(echo $${LITERAL_HASH}define VCS_SHORT_HASH $$VERSION_HASH >> $$REVFILE)
  } else {
    system(echo \\$${LITERAL_HASH}define APPLICATION_NAME \\\"$$APPLICATION_NAME\\\" > $$REVFILE)
    system(echo \\$${LITERAL_HASH}define ORGANIZATION_NAME \\\"$$ORGANIZATION_NAME\\\" >> $$REVFILE)
    system(echo \\$${LITERAL_HASH}define VCS_REVISION \\\"$$VERSION_REV\\\" >> $$REVFILE)
    system(echo \\$${LITERAL_HASH}define VCS_SHORT_HASH \\\"$$VERSION_HASH\\\" >> $$REVFILE)
  }
} else:!exists($$REVFILE) {
  VERSION_REV = 0
  VERSION_HASH = \"\"
  !build_pass:message(VCS revision: $$VERSION_REV VCS short hash:$$VERSION_HASH)

  os2|win32 {
    system(echo $${LITERAL_HASH}define APPLICATION_NAME $$APPLICATION_NAME > $$REVFILE)
    system(echo $${LITERAL_HASH}define ORGANIZATION_NAME $$ORGANIZATION_NAME >> $$REVFILE)
    system(echo $${LITERAL_HASH}define VCS_REVISION $$VERSION_REV >> $$REVFILE)
    system(echo $${LITERAL_HASH}define VCS_SHORT_HASH $$VERSION_HASH >> $$REVFILE)
  } else {
    system(echo \\$${LITERAL_HASH}define APPLICATION_NAME \\\"$$APPLICATION_NAME\\\" > $$REVFILE)
    system(echo \\$${LITERAL_HASH}define ORGANIZATION_NAME \\\"$$ORGANIZATION_NAME\\\" >> $$REVFILE)
    system(echo \\$${LITERAL_HASH}define VCS_REVISION \\\"$$VERSION_REV\\\" >> $$REVFILE)
    system(echo \\$${LITERAL_HASH}define VCS_SHORT_HASH \\\"$$VERSION_HASH\\\" >> $$REVFILE)
  }
}

isEqual(QT_MAJOR_VERSION, 5) {
  !versionAtLeast(QT_VERSION, 5.15.0) {
    message("Cannot use Qt $${QT_VERSION}")
    error("Please use Qt 5.15")
  }
}
else {
  message("Cannot use Qt $${QT_VERSION}")
  error("Please use Qt 5.15")
}

QT += widgets webkitwidgets network xml sql multimedia

equals(WEBKIT_ALPHA, true) {
    DEFINES += WEBKIT_ALPHA
}

unix:!mac:DEFINES += HAVE_X11

TEMPLATE = app

HEADERS += \
    src/VersionNo.h \
    src/parseobject.h \
    src/optionsdialog.h \
    src/newsview/newsview.h \
    src/newsview/newsmodel.h \
    src/newsview/newsheader.h \
    src/aboutdialog.h \
    src/feedpropertiesdialog.h \
    src/addfeedwizard.h \
    src/newstabwidget.h \
    src/findtext.h \
    src/findfeed.h \
    src/feedsview/feedsview.h \
    src/feedsview/feedsmodel.h \
    src/VersionRev.h \
    src/addfolderdialog.h \
    src/labeldialog.h \
    src/faviconobject.h \
    src/customizetoolbardialog.h \
    src/plugins/webpluginfactory.h \
    src/downloads/downloadmanager.h \
    src/downloads/downloaditem.h \
    src/tabbar.h \
    src/categoriestreewidget.h \
    src/cleanupwizard.h \
    src/updatefeeds.h \
    src/requestfeed.h \
    src/notifications/notificationsfeeditem.h \
    src/notifications/notificationsnewsitem.h \
    src/notifications/notificationswidget.h \
    src/application/mainapplication.h \
    src/application/settings.h \
    src/application/logfile.h \
    src/application/mainwindow.h \
    src/adblock/adblocktreewidget.h \
    src/adblock/adblocksubscription.h \
    src/adblock/adblocksearchtree.h \
    src/adblock/adblockrule.h \
    src/adblock/adblockmanager.h \
    src/adblock/adblockicon.h \
    src/adblock/adblockdialog.h \
    src/adblock/adblockblockednetworkreply.h \
    src/adblock/adblockaddsubscriptiondialog.h \
    src/adblock/followredirectreply.h \
    src/application/splashscreen.h \
    src/network/authenticationdialog.h \
    src/network/cookiejar.h \
    src/network/networkmanager.h \
    src/webview/locationbar.h \
    src/webview/rssdetectionwidget.h \
    src/webview/webpage.h \
    src/webview/webview.h \
    src/database/database.h \
    src/common/common.h \
    src/common/delegatewithoutfocus.h \
    src/common/dialog.h \
    src/common/lineedit.h \
    src/common/toolbutton.h \
    src/newsfilters/filterrulesdialog.h \
    src/newsfilters/newsfiltersdialog.h \
    src/newsfilters/itemcondition.h \
    src/newsfilters/itemaction.h \
    src/network/sslerrordialog.h \
    src/network/networkmanagerproxy.h \
    src/adblock/adblockmatcher.h \
    src/feedsview/feedsproxymodel.h \
    src/main/globals.h \

SOURCES += \
    src/parseobject.cpp \
    src/optionsdialog.cpp \
    src/newsview/newsview.cpp \
    src/newsview/newsmodel.cpp \
    src/newsview/newsheader.cpp \
    src/aboutdialog.cpp \
    src/feedpropertiesdialog.cpp \
    src/addfeedwizard.cpp \
    src/newstabwidget.cpp \
    src/findtext.cpp \
    src/findfeed.cpp \
    src/feedsview/feedsview.cpp \
    src/feedsview/feedsmodel.cpp \
    src/addfolderdialog.cpp \
    src/labeldialog.cpp \
    src/faviconobject.cpp \
    src/customizetoolbardialog.cpp \
    src/plugins/webpluginfactory.cpp \
    src/downloads/downloadmanager.cpp \
    src/downloads/downloaditem.cpp \
    src/tabbar.cpp \
    src/categoriestreewidget.cpp \
    src/cleanupwizard.cpp \
    src/updatefeeds.cpp \
    src/requestfeed.cpp \
    src/notifications/notificationsfeeditem.cpp \
    src/notifications/notificationsnewsitem.cpp \
    src/notifications/notificationswidget.cpp \
    src/application/mainapplication.cpp \
    src/application/settings.cpp \
    src/application/logfile.cpp \
    src/application/mainwindow.cpp \
    src/main/globals.cpp \
    src/main/main.cpp \
    src/adblock/adblocktreewidget.cpp \
    src/adblock/adblocksubscription.cpp \
    src/adblock/adblocksearchtree.cpp \
    src/adblock/adblockrule.cpp \
    src/adblock/adblockmanager.cpp \
    src/adblock/adblockicon.cpp \
    src/adblock/adblockdialog.cpp \
    src/adblock/adblockblockednetworkreply.cpp \
    src/adblock/adblockaddsubscriptiondialog.cpp \
    src/adblock/followredirectreply.cpp \
    src/application/splashscreen.cpp \
    src/network/authenticationdialog.cpp \
    src/network/cookiejar.cpp \
    src/network/networkmanager.cpp \
    src/webview/locationbar.cpp \
    src/webview/rssdetectionwidget.cpp \
    src/webview/webpage.cpp \
    src/webview/webview.cpp \
    src/database/database.cpp \
    src/common/common.cpp \
    src/common/delegatewithoutfocus.cpp \
    src/common/dialog.cpp \
    src/common/lineedit.cpp \
    src/common/toolbutton.cpp \
    src/newsfilters/filterrulesdialog.cpp \
    src/newsfilters/newsfiltersdialog.cpp \
    src/newsfilters/itemcondition.cpp \
    src/newsfilters/itemaction.cpp \
    src/network/sslerrordialog.cpp \
    src/network/networkmanagerproxy.cpp \
    src/adblock/adblockmatcher.cpp \
    src/feedsview/feedsproxymodel.cpp

INCLUDEPATH +=  $$PWD/src \
                $$PWD/src/application \
                $$PWD/src/common \
                $$PWD/src/main \
                $$PWD/src/database \
                $$PWD/src/downloads \
                $$PWD/src/feedsview \
                $$PWD/src/newsfilters \
                $$PWD/src/newsview \
                $$PWD/src/notifications \
                $$PWD/src/plugins \
                $$PWD/src/adblock \
                $$PWD/src/network \
                $$PWD/src/webview \

CONFIG += debug_and_release
CONFIG(debug, debug|release) {
  BUILD_DIR = $$OUT_PWD/debug
} else {
  BUILD_DIR = $$OUT_PWD/release
  CONFIG += optimize_full
#  DEFINES += QT_NO_DEBUG_OUTPUT
}

DESTDIR = $${BUILD_DIR}/target
OBJECTS_DIR = $${BUILD_DIR}/obj
MOC_DIR = $${BUILD_DIR}/moc
RCC_DIR = $${BUILD_DIR}/rcc

isEmpty(SYSTEMQTSA) {
  include(3rdparty/qtsingleapplication/qtsingleapplication.pri)
} else {
  CONFIG += qtsingleapplication
}

include(3rdparty/qftp/qftp.pri)
include(3rdparty/sqlite.pri)
include(lang/lang.pri)
include(3rdparty/qupzilla/qupzilla.pri)

os2|win32|mac {
  TARGET = $$APPLICATION_NAME
}

win32 {
  RC_FILE = resources.rc
}

win32-g++ {
  LIBS += libkernel32 \
          libpsapi
}

*-g++* {
  CONFIG(debug, debug|release) {
  } else {
    QMAKE_CXXFLAGS += -pipe -flto
    QMAKE_CFLAGS += -pipe
    QMAKE_LFLAGS += -flto
  }
}

win32-msvc* {
  LIBS += -lpsapi
  LIBS += -lShell32
  LIBS += -lUser32

  QMAKE_CXXFLAGS += -D__PRETTY_FUNCTION__=__FUNCTION__
  QMAKE_CFLAGS += -D__PRETTY_FUNCTION__=__FUNCTION__
}

os2 {
  RC_FILE = resources_os2.rc
}

os2 {
  SOURCES += src/network/cabundleupdater.cpp
  HEADERS += src/network/cabundleupdater.h
}

os2|win32 {
  RESOURCES += data/ca-bundle.qrc
}

DISTFILES += \
    HISTORY_RU \
    HISTORY_EN \
    LICENSE \
    AUTHORS \
    CHANGELOG \
    README.md

unix:!mac {
  TARGET = $$PROJECT_NAME

  isEmpty(PREFIX) {
    PREFIX =   /usr/local
  }
  DATA_DIR = $$PREFIX/share/$$PROJECT_NAME
  DEFINES += RESOURCES_DIR='\\\"$${DATA_DIR}\\\"'

  target.path =  $$quote($$PREFIX/bin)

  desktop.files = $$PROJECT_NAME.desktop
  desktop.path =  $$quote($$PREFIX/share/applications)

  appdata.files = $$PROJECT_NAME.appdata.xml
  appdata.path =  $$quote($$PREFIX/share/metainfo)

  target1.files = images/48x48/$$PROJECT_NAME.png
  target1.path =  $$quote($$PREFIX/share/pixmaps)

  icon_16.files =  images/16x16/$$PROJECT_NAME.png
  icon_32.files =  images/32x32/$$PROJECT_NAME.png
  icon_48.files =  images/48x48/$$PROJECT_NAME.png
  icon_64.files =  images/64x64/$$PROJECT_NAME.png
  icon_128.files = images/128x128/$$PROJECT_NAME.png
  icon_256.files = images/256x256/$$PROJECT_NAME.png
  icon_16.path =  $$quote($$PREFIX/share/icons/hicolor/16x16/apps)
  icon_32.path =  $$quote($$PREFIX/share/icons/hicolor/32x32/apps)
  icon_48.path =  $$quote($$PREFIX/share/icons/hicolor/48x48/apps)
  icon_64.path =  $$quote($$PREFIX/share/icons/hicolor/64x64/apps)
  icon_128.path = $$quote($$PREFIX/share/icons/hicolor/128x128/apps)
  icon_256.path = $$quote($$PREFIX/share/icons/hicolor/256x256/apps)

  translations.files = $$quote($$DESTDIR/lang)
  translations.path =  $$quote($$DATA_DIR)
  translations.CONFIG += no_check_exist

  sound.files = sound
  sound.path = $$quote($$DATA_DIR)

  style.files = style
  style.path = $$quote($$DATA_DIR)

  INSTALLS += target desktop appdata target1
  INSTALLS += icon_16 icon_32 icon_48 icon_64 icon_128 icon_256
  INSTALLS += translations sound style
}

mac {
  CONFIG += app_bundle
  QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.6

  QMAKE_INFO_PLIST = Info.plist
  ICON = $$PROJECT_NAME.icns

  bundle_target.files += AUTHORS
  bundle_target.files += LICENSE
  bundle_target.files += CHANGELOG
  bundle_target.files += README.md
  bundle_target.files += sound
  bundle_target.files += style
  bundle_target.path = Contents/Resources
  QMAKE_BUNDLE_DATA += bundle_target

  translations.files = $$quote($$DESTDIR/lang)
  translations.path =  Contents/Resources
  QMAKE_BUNDLE_DATA += translations

  INSTALLS += bundle_target translations
}

RESOURCES += \
  resources.qrc

FORMS += \
    src/adblock/adblockdialog.ui \
    src/adblock/adblockaddsubscriptiondialog.ui
