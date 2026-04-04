
#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    // 尝试加载你上传的字体文件
    int fontId = QFontDatabase::addApplicationFont("/usr/lib/fonts/simhei.ttf"); 
    
    if (fontId != -1) {
        QString family = QFontDatabase::applicationFontFamilies(fontId).at(0);
        QFont font(family);
        font.setPointSize(12); // 设置一个合适的大小
        a.setFont(font);       // 应用到全局
        qDebug() << "Font loaded successfully:" << family;
    } else {
        qDebug() << "Critical: Cannot load font file!";
    }

    MainWindow w;
    w.setGeometry(0, 0, 800, 600);
    w.setStyleSheet("background-color: green;");
    w.show();

    return a.exec();
}
