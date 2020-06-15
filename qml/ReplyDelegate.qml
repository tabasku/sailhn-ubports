import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

ListItem {
    height: contentItem.childrenRect.height + units.gu(1)
    width: parent.width
    selected: false
    swipeEnabled: false

    Column {
        width: parent.width
        //spacing: units.gu(0.5)
        //padding: units.gu(0.5)

        Text {
            width: parent.width
            textFormat: Text.RichText
            text: "<style>a:link{color: " + theme.palette.highlighted.baseText + ";}</style>" + itemText
            color: theme.palette.highlighted.baseText
            wrapMode: Text.Wrap

            onLinkActivated: {
                console.log("Opening external browser: " + link);
                Qt.openUrlExternally(link)
            }
        }

        Label {
            width: parent.width
            color: theme.palette.highlighted.baseText

            text: {
                var txt = by;
                if (kids.length !== 0) {
                    txt += " - " + kids.length + ' ';
                    if (kids.length === 1) {
                        txt += qsTr("reply");
                    } else {
                        txt += qsTr("replies");
                    }
                }

                return txt + " - " + Qt.formatDateTime(time, "ddd, hh:mm");
            }
        }
    }

    onClicked: {
        if (kids.length !== 0) {
            pageStack.push(Qt.resolvedUrl("RepliesPage.qml"), {parentId: id, dead: dead, kids: kids});
        }
    }
}
