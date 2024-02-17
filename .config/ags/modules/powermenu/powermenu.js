import { Widget, Utils } from "../../imports.js";
const { Box } = Widget;
const { execAsync } = Utils;
import PopupWindow from "../../utils/popupWindow.js";


export const PowerMenu = () =>  PopupWindow({
    name: "powermenu",
    keymode: "onDemand",
    transition: "slide_down",
    transitionDuration: 150,
    child: Box({
        children:[
        Widget.Button({
            className: "powermenu",
            onClicked: () => {
                App.closeWindow('powermenu');
            },
        }),
        ]
    }),
});
