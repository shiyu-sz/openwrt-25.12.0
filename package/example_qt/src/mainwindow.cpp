
#include "mainwindow.h"

#include <QDebug>
#include <QApplication>
#include <QtWidgets>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    QLabel *label = new QLabel(this);
    label->setText("test");
    label->setGeometry(100, 300, 100, 50);

    button = new QPushButton(this);
    button->setText("test");
    button->setGeometry(200, 300, 100, 50);
    button->setStyleSheet("QPushButton { background-color: red; }");
    connect(button, SIGNAL(clicked()), this, SLOT(slots_button_clicked()));
}

MainWindow::~MainWindow()
{

}

void MainWindow::slots_button_clicked()
{
    static int bth_count = 0;
    bth_count ++;
    button->setText("test"+QString::number(bth_count));
}
