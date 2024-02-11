import { Widget, Utils } from "../../imports.js"
const { execAsync } = Utils;

export const PowerIcon = () => Widget.Button({
    className: 'Icon',
    child: Widget.Label({ label:"⏻" }),
    onClicked: () => {
        App.closeWindow('dashboard');
    },
})
export const TerminalIcon = () => Widget.Button({
    className: 'Icon',
    child: Widget.Label({ label:"󰄛" }),
    onClicked: () => {
        execAsync(['bash', '-c', 'kitty', '&']);
        App.closeWindow('dashboard');

    },

})
