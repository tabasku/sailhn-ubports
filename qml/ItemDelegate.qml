import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.Pickers 1.3

ListItem {
    width: ListView.view.width
    height: col.height

    Column {
        id: col
        x: units.gu(4)
        width: parent.width - units.gu(2) * 2

        Label {
            color: theme.palette.normal.baseText
            width: parent.width
            text: title
            //font.pixelSize: Theme.fontSizeMedium
            //truncationMode: TruncationMode.Fade
            maximumLineCount: 2
            wrapMode: Text.WordWrap
        }

        Label {
            width: parent.width
            color: theme.palette.highlighted.baseText
            //font.pixelSize: Theme.fontSizeSmall
            horizontalAlignment: Text.AlignRight

            text: {
                var txt = score + ' ';
                if (score === 1) {
                    txt += qsTr("point");
                } else {
                    txt += qsTr("points");
                }

                if (kids.length !== 0) {
                    txt += " - " + descendants + ' ';
                    if (descendants === 1) {
                        txt += qsTr("comment");
                    } else {
                        txt += qsTr("comments");
                    }
                }

                return txt + " - " + Qt.formatDateTime(time, "ddd, hh:mm");
            }
        }
    }

    onClicked: {
        pageStack.push(Qt.resolvedUrl("CommentsPage.qml"), {
                           id: id,
                           by: by,
                           dead: dead,
                           itemText: itemText,
                           kids: kids,
                           time: time,
                           title: title,
                           url: url
                       });
    }
}
