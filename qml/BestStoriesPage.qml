import QtQuick 2.7
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {

    property bool storiesLoadedOnce: false

    TabsList {
        id: tabsList
    }

    header: PageHeader {
        id: header
        title: i18n.tr('Best')

        leadingActionBar {
            numberOfSlots: 0
            actions: tabsList.actions
        }

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

    StoriesListView {
        id: listView
        pageTitle: "Best"
        anchors{
            fill: parent
            topMargin: header.height + units.gu(0.5)
        }

        /* disable the dragging features of the ListModel elements */
        boundsBehavior: Flickable.StopAtBounds

        focus: true
        /* set clip:true to prevent that UbuntuListView draw out of his assigned rectangle, default is false */
        clip: true

        onRefreshClicked: loadStories()
    }


    /* to have a scroll bar we ListModel size exceed the page heigth */
    Scrollbar {
        flickableItem: listView
        align: Qt.AlignTrailing
    }

    Component.onCompleted: loadStories();

    function loadStories() {
        listView.stories.loadBestStories();
    }
}
