import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import sailhn.sailhn 1.0

UbuntuListView {
    id: listView
    anchors.fill: parent

    /* amount of space from the above component */
    //anchors.topMargin: units.gu(10)

    /* disable the dragging features of the ListModel elements */
    boundsBehavior: Flickable.StopAtBounds

    focus: true
    /* set clip:true to prevent that UbuntuListView draw out of his assigned rectangle, default is false */
    clip: true

    property string pageTitle
    //property alias submitEnabled: submit.enabled
    property alias stories: model

    signal refreshClicked

    Connections {
        target: manager
/*
        onLoggedUserFetched: {
            submit.enabled = true;
        }*/
    }
/*
    PullDownMenu {

        MenuItem {
            text: qsTr("Settings")

            onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
        }

        MenuItem {
            id: submit
            text: qsTr("Submit")
            enabled: false

            onClicked: pageStack.push(Qt.resolvedUrl("Submit.qml"))
        }

        MenuItem {
            text: qsTr("Refresh")

            onClicked: listView.refreshClicked()
        }
    }

    PushUpMenu {

        MenuItem {
            text: qsTr("Load more")

            onClicked: model.nextItems()
        }
    }

    */

    model: NewsModel {
        id: model
    }

    delegate: ItemDelegate {}

    //VerticalScrollDecorator {}
}
    