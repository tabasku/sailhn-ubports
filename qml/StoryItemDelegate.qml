import QtQuick 2.7
import Ubuntu.Components 1.3

ListItem {
  id: container

  contentItem.anchors {
    leftMargin: units.gu(2)
    rightMargin: units.gu(2)
    topMargin: units.gu(0.5)
    bottomMargin: units.gu(0.5)
  }

  height: units.gu(1) + containerTitle.height * 2 + containerInfo.height

  // Put contents in a 'box'
  Item {
    anchors {
      centerIn: parent
    }

    // Adjust width on big screens (e.g. tablets or extended display), Ubuntu Touch's convergence feature
    height: parent.height //- units.gu(4)
    width: {
      if (root.width > units.gu(85)) {
        units.gu(81)
      }
      else {
        parent.width - units.gu(4)
      }
    }

  Column {
    id: topLayout
    //x: 10; y: 7;
    height: parent.height
    width: parent.width
    spacing: units.gu(0.5)
    anchors {
      centerIn: parent
    }
  
    Label {
        id: containerTitle
        width: parent.width //- units.gu(1)
        // anchors {
        //   topMargin: units.gu(1)
        //   leftMargin: units.gu(1)
        // }
        color: theme.palette.highlighted.baseText
        text: title
        textSize: Label.Medium
        wrapMode: Text.WordWrap
      }

    Label {
      id: containerInfo
      width: parent.width //- units.gu(1)
      color: theme.palette.highlighted.baseText
      textSize: Label.Small
      wrapMode: Text.WordWrap
      //horizontalAlignment: Text.AlignRight
      // anchors {
      //   topMargin: units.gu(1)
      //   leftMargin: units.gu(1)
      // }

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
