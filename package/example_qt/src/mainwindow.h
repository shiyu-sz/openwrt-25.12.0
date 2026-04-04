
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtWidgets>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    QPushButton *button = NULL;

protected:

private:

protected slots:
    void slots_button_clicked();
private:

private:

};

#endif // MAINWINDOW_H
