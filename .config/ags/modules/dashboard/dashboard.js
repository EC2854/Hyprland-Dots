import { Widget } from "../../imports.js";
const { Box } = Widget;
import PopupWindow from "../../utils/popupWindow.js";

import { VolumeSlider } from "./volumeSlider.js"
import { WiFi } from "./wifi.js";
import { BluetoothWidget } from "./bluetooth.js";

export const Dashboard = () =>  PopupWindow({
    name: "dashboard",
    anchor: ["top", "right"],
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
                        className: "wbbox",
                        vertical: false,
                        children: [ 
                            WiFi(),
                            BluetoothWidget(),
                        ]

                    }),
                    VolumeSlider(),
                ],
            }),
        ],
    }),
});
