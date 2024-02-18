import { Widget, Utils } from "../../imports.js";
const { Box } = Widget;
const { execAsync } = Utils;
import PopupWindow from "../../utils/popupWindow.js";

import { PowerIcon, TerminalIcon } from "./iconButtons.js"
import { WiFi } from "./wifi.js";
import { BluetoothWidget } from "./bluetooth.js";
import { VolumeSlider } from "./volumeSlider.js"
import { BrightnessSlider } from "./brightnessSlider.js";
import { NotificationList } from "./notificationList.js";
import { CalendarWidget } from "./calendar.js";

const uptime = Box({
    children: [
        Widget.Label({
            setup: (self) => self
                .poll(5000, label => {
                    execAsync(['bash', '-c', `w | sed -n '1p' | cut -d, -f1 | cut -d' ' -f4-`]) 
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
export const Dashboard = () =>  PopupWindow({
    name: "dashboard",
    anchor: ["top","bottom", "right"],
    margins: [12, 12, 15],
    transition: "slide_left",
    transitionDuration: 150,
    child: 
        Box({
            vertical:true,
            children: [
                Box({
                    className: "quicktoggles",
                    vertical: true,
                    vexpand: false,
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
                NotificationList(),
                CalendarWidget(),
            ]
        })
});
