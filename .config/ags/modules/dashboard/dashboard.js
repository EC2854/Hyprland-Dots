import { Widget, Utils } from "../../imports.js";
const { Box } = Widget;
const { execAsync } = Utils;
import PopupWindow from "../../utils/popupWindow.js";
import Gtk from 'gi://Gtk';

import { PowerIcon, TerminalIcon } from "./iconButtons.js"
import { VolumeSlider } from "./volumeSlider.js"
import { WiFi } from "./wifi.js";
import { BluetoothWidget } from "./bluetooth.js";
import { BrightnessSlider } from "./brightnessSlider.js";

const uptime = Box({
    children: [
        Widget.Label({
            setup: (self) => self
                .poll(5000, label => {
                    execAsync(['bash', '-c', `uptime | awk '{gsub(",", "", $3); print $3}'`])
                        .then(upTimeString => {
                            label.label = `Uptime: ${upTimeString}`;
                        }).catch(print);
                })
            ,
        }),
        Box({ hexpand: true }),
        TerminalIcon({ hpack: 'end' }),
        PowerIcon({ hpack: 'end' }),
    ]
});
const Calendar = Widget.subclass(Gtk.Calendar)({
    showDayNames: true,
    showHeading: true,
    className: 'calendarWidget',
});
export const Dashboard = () =>  PopupWindow({
    name: "dashboard",
    anchor: ["top","bottom", "right"],
    margins: [12, 15],
    transition: "slide_left",
    transitionDuration: 150,
    child: Box({
        vertical: true,
        children: [
            Box({
                className: "dashboard",
                vertical: true,
                children: [
                    Box({
                        vertical: true,
                        vpack: 'start',
                        children: [
                            Box({
                                className: "quicktoggles",
                                vertical: true,
                                children: [
                                    uptime,
                                    Box({
                                        className: "buttons",
                                        children: [
                                            WiFi(),
                                            BluetoothWidget(),
                                        ]
                                    }),
                                ]   
                            }),
                            VolumeSlider(),
                            // BrightnessSlider(),
                        ],
                    }),
                    Box({
                        vpack: 'fill',
                        vexpand: true,
                        vertical: true,
                        className: "notifications",
                    }),
                    Box({
                        className: "calendar",
                        vpack: 'end',
                        vertical: true,
                        children: [
                            Calendar,
                        ],
                    })
                ],
            }),
        ],
    }),
});
