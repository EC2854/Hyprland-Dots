// import { Widget, Notifications } from "../../imports.js"

const Notifications = await Service.import("notifications");
const { Box } = Widget

export const Notification = () => Box({
    class_name: 'barNotification',
    visible: Notifications.bind('popups').transform(p => p.length > 0),
    children: [
        Widget.Label({
            label: '󰍡 ',
        }),
        Widget.Label({
            label: Notifications.bind('popups').transform(p => {
                const summary = p[0]?.summary || '';
                const maxLength = 50;
                return summary.length > maxLength ? summary.slice(0, maxLength) + '...' : summary;
            }),
        }),
    ],
});
