import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import sailhn.sailhn 1.0

Page {

    header: PageHeader {
        id: header
        title: i18n.tr('Submit')

        StyleHints {
            foregroundColor: UbuntuColors.inkstone
            backgroundColor: headerBackgroundColor
            dividerColor: UbuntuColors.ash
        }
    }

    Rectangle{
        color: storyBackgroundColor
        anchors.fill: parent
    }

    Connections {
        target: manager

        onSubmitted: {
            console.log("Submitted: " + result);

            busy.visible = busy.running = false;
            submit.enabled = true;
            msg.visible = true;

            if (!result) {
                msg.text = qsTr("Error during submission");
            } else {
                msg.text = qsTr("Submitted!");
            }
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            x: Theme.horizontalPageMargin
            width: parent.width - Theme.horizontalPageMargin * 2

            PageHeader {
                title: qsTr("Submit")
            }

            TextField {
                id: title
                width: parent.width
                focus: true
                placeholderText: qsTr("Title")

                onTextChanged: submit.enabled = (text.length > 0 && (url.text.length > 0 || itemText.text.length > 0))
            }

            TextField {
                id: url
                width: parent.width
                placeholderText: qsTr("Url")

                onTextChanged: submit.enabled = (title.text.length > 0 && (text.length > 0 || itemText.text.length > 0))
            }

            Label {
                text: qsTr("or")
                color: Theme.secondaryHighlightColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextArea {
                id: itemText
                width: parent.width
                placeholderText: qsTr("Text")

                onTextChanged: submit.enabled = (title.text.length > 0 && (url.text.length > 0 || text.length > 0))
            }

            Button {
                id: submit
                text: qsTr("Submit");
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: false

                onClicked: {
                    manager.submit(title.text, url.text, itemText.text);
                    submit.enabled = false;
                    busy.visible = busy.running = true;
                    msg.visible = false;
                }
            }

            Label {
                id: msg
                visible: false
                color: Theme.highlightColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BusyIndicator {
                id: busy
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
