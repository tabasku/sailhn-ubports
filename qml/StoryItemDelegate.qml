import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3

ListItem {
  height: contentItem.childrenRect.height + units.gu(1)
  width: parent.width
  selected: false
  swipeEnabled: false

  Column {
    width: parent.width - units.gu(1) * 2
    spacing: units.gu(1)
    padding: units.gu(1)

    Label {
        id: containerTitle
        width: parent.width
        color: theme.palette.highlighted.baseText
        text: title
        textSize: Label.Medium
        wrapMode: Text.WordWrap
      }

    Label {
      id: containerInfo
      width: parent.width
      color: theme.palette.highlighted.baseText
      textSize: Label.Small
      wrapMode: Text.WordWrap

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
    console.log(id)
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
