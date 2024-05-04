const { Box } = Widget;
import PopupWindow from "../../utils/popupWindow.js";
import { VolumeSlider } from "./volumeSlider.js"
import { BrightnessSlider } from "./brightnessSlider.js"
import { Buttons } from "./buttons.js"
import { NotificationList } from "./notificationList.js";
import { CalendarWidget } from "./calendar.js";

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
                Buttons(),
                VolumeSlider(),
                // BrightnessSlider(),
                NotificationList(),
                CalendarWidget(),
            ]
        })
});
