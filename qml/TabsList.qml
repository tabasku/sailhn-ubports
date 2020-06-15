import QtQuick 2.7
import Ubuntu.Components 1.3

ActionList {
    id: tabsList

    children: [
        Action {
            iconName: "preferences-desktop-login-items-symbolic"
            text: i18n.tr("Top")
            enabled: tabs.selectedTab !== topStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 0
            }
        },

        Action {
            iconName: "non-starred"
            text: i18n.tr("Newest")
            enabled: tabs.selectedTab !== newStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 1
            }
        },

        Action {
            iconName: "broadcast"
            text: i18n.tr("Show")
            enabled: tabs.selectedTab !== showStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 2
            }
        },

        Action {
            iconName: "dialog-question-symbolic"
            text: i18n.tr("Ask")
            enabled: tabs.selectedTab !== askStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 3
            }
        },

        Action {
            iconName: "system-users-symbolic"
            text: i18n.tr("Jobs")
            enabled: tabs.selectedTab !== jobStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 4
            }
        },

        Action {
            iconName: "thumb-up"
            text: i18n.tr("Best")
            enabled: tabs.selectedTab !== bestStoriesTab
            onTriggered: {
                tabs.selectedTabIndex = 5
            }
        },

        Action {
            iconName: "settings"
            text: i18n.tr("Settings")
            enabled: tabs.selectedTab !== settingsTab
            onTriggered: {
                tabs.selectedTabIndex = 6
            }
        }
    ]
}
