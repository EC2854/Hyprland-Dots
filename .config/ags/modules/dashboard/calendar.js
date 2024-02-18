import Gtk from 'gi://Gtk';
import { Widget } from "../../imports.js";
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
