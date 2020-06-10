/*
 * Copyright (C) 2020  Joni Kurunsaari
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * sailhn is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>
#include <QQmlContext>

#include "hnmanager.h"
#include "newsmodel.h"
#include "user.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(new QGuiApplication(argc, argv));
    QScopedPointer<QQuickView> view(new QQuickView());

    app->setApplicationName("sailhn.sailhn");

    qmlRegisterType<NewsModel>("sailhn.sailhn", 1, 0, "NewsModel");
    qmlRegisterType<User>("sailhn.sailhn", 1, 0, "User");

    HNManager manager;
    view->rootContext()->setContextProperty("manager", &manager);

    qDebug() << "Starting app from main.cpp";

    
    view->setSource(QUrl("qrc:/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    return app->exec();
}
