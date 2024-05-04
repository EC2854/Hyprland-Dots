import Gtk from 'gi://Gtk';
const { Box } = Widget;

export const CalendarWidget = () => Box({
    className: "calendar",
    vpack: 'end',
    vertical: true,
    children: [ 
        Widget.subclass(Gtk.Calendar)({
            showDayNames: true,
            showHeading: true,
            className: 'calendarWidget',
        })
    ]
})
