QT += quick qml 3dcore 3drender 3dinput 3dquick 3dlogic 3dquickextras

SOURCES += \
        main.cpp
lupdate_only{
    SOURCES+= main.qml
}

RESOURCES += qml.qrc \
    res.qrc

TRANSLATIONS += \
    simple_tree_ru_RU.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


