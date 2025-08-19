INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

TRANSLATIONS += lang/de.ts lang/ru.ts \
                lang/es.ts lang/fr.ts lang/hu.ts \
                lang/sv.ts lang/sr.ts lang/nl.ts \
                lang/fa.ts lang/it.ts lang/zh_CN.ts \
                lang/uk.ts lang/cs.ts lang/pl.ts \
                lang/ja.ts lang/ko.ts lang/pt_BR.ts \
                lang/lt.ts lang/zh_TW.ts lang/el_GR.ts \
                lang/tr.ts lang/ar.ts lang/sk.ts \
                lang/tg_TJ.ts lang/pt_PT.ts lang/vi.ts \
                lang/ro_RO.ts lang/fi.ts lang/gl.ts \
                lang/bg.ts lang/hi.ts

isEmpty(QMAKE_LRELEASE) {
  Q_OS_WIN:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\lrelease.exe
  else:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
}

updateqm.input = TRANSLATIONS
updateqm.output = $$DESTDIR/lang/${QMAKE_FILE_BASE}.qm
updateqm.commands = $$QMAKE_LRELEASE ${QMAKE_FILE_IN} -qm $$DESTDIR/lang/${QMAKE_FILE_BASE}.qm
updateqm.CONFIG += no_link target_predeps
QMAKE_EXTRA_COMPILERS += updateqm
